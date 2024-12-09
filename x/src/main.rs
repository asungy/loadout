#![allow(clippy::all, missing_debug_implementations)]

mod app;

use ratatui::backend::CrosstermBackend;
use ratatui::crossterm::event::{DisableMouseCapture, EnableMouseCapture};
use ratatui::crossterm::execute;
use ratatui::crossterm::terminal::{
    disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen,
};

fn run_app<B: ratatui::backend::Backend>(terminal: &mut ratatui::Terminal<B>, app: &mut app::App) -> std::io::Result<bool> {
    loop {
        terminal.draw(|f| ui(f, app))?;

        if let crossterm::event::Event::Key(key) = crossterm::event::read()? {
            if key.kind == crossterm::event::KeyEventKind::Release {
                // Skip events that are not KeyEventKind::Press
                continue;
            }
            match app.current_screen {
                app::CurrentScreen::Main => match key.code {
                    crossterm::event::KeyCode::Char('e') => {
                        app.current_screen = app::CurrentScreen::Editing;
                        app.currently_editing = Some(app::CurrentlyEditing::Key);
                    },
                    crossterm::event::KeyCode::Char('q') => {
                        app.current_screen = app::CurrentScreen::Exiting;
                    },
                    _ => {},
                },
                // LEFT OFF: https://ratatui.rs/tutorials/json-editor/main/
                app::CurrentScreen::Editing => todo!(),
                app::CurrentScreen::Exiting => match key.code {
                    crossterm::event::KeyCode::Char('y') => {
                        return Ok(true)
                    },
                    crossterm::event::KeyCode::Char('n') | crossterm::event::KeyCode::Char('q') => {
                        return Ok(false)
                    },
                    _ => {},
                },
            }
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    enable_raw_mode()?;

    let mut stderr = std::io::stderr();
    execute!(stderr, EnterAlternateScreen, EnableMouseCapture)?;

    let backend = CrosstermBackend::new(stderr);
    let mut terminal = ratatui::Terminal::new(backend)?;

    let mut app = app::App::new();
    let res = run_app(&mut terminal, &mut app);

    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture,
    )?;
    terminal.show_cursor()?;

    if let Ok(do_print) = res {
        if do_print {
            app.print_json()?;
        }
    } else if let Err(err) = res {
        println!("{err:?}");
    }

    Ok(())
}
