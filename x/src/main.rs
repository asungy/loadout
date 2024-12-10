#![allow(clippy::all, missing_debug_implementations)]

mod app;
mod ui;

use crossterm::event::KeyCode;
use ratatui::backend::CrosstermBackend;
use ratatui::crossterm::event::{DisableMouseCapture, EnableMouseCapture};
use ratatui::crossterm::execute;
use ratatui::crossterm::terminal::{
    disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen,
};

fn run_app<B: ratatui::backend::Backend>(terminal: &mut ratatui::Terminal<B>, app: &mut app::App) -> std::io::Result<bool> {
    loop {
        terminal.draw(|f| ui::ui(f, app))?;

        if let crossterm::event::Event::Key(key) = crossterm::event::read()? {
            if key.kind == crossterm::event::KeyEventKind::Release {
                // Skip events that are not KeyEventKind::Press
                continue;
            }
            match app.current_screen {
                app::CurrentScreen::Main => match key.code {
                    KeyCode::Char('e') => {
                        app.current_screen = app::CurrentScreen::Editing;
                        app.currently_editing = Some(app::CurrentlyEditing::Key);
                    },
                    KeyCode::Char('q') => {
                        app.current_screen = app::CurrentScreen::Exiting;
                    },
                    _ => {},
                },
                app::CurrentScreen::Editing if key.kind == crossterm::event::KeyEventKind::Press => {
                    match key.code {
                        KeyCode::Enter => {
                            if let Some(editing) = &app.currently_editing {
                                match editing {
                                    app::CurrentlyEditing::Key => {
                                        app.currently_editing = Some(app::CurrentlyEditing::Value);
                                    },
                                    app::CurrentlyEditing::Value => {
                                        app.save_key_value();
                                        app.current_screen = app::CurrentScreen::Main;
                                    },
                                }
                            }
                        },
                        KeyCode::Backspace => {
                            if let Some(editing) = &app.currently_editing {
                                match editing {
                                    app::CurrentlyEditing::Key => {
                                        app.key_input.pop();
                                    },
                                    app::CurrentlyEditing::Value => {
                                        app.value_input.pop();
                                    },
                                }
                            }
                        },
                        KeyCode::Esc => {
                            app.current_screen = app::CurrentScreen::Main;
                            app.currently_editing = None;
                        },
                        KeyCode::Tab => {
                            app.toggle_editing();
                        },
                        KeyCode::Char(value) => {
                            if let Some(editing) = &app.currently_editing {
                                match editing {
                                    app::CurrentlyEditing::Key => {
                                        app.key_input.push(value);
                                    },
                                    app::CurrentlyEditing::Value => {
                                        app.value_input.push(value);
                                    },
                                }
                            }
                        },
                        _ => {},
                    }
                },
                app::CurrentScreen::Exiting => match key.code {
                    KeyCode::Char('y') => {
                        return Ok(true)
                    },
                    KeyCode::Char('n') | KeyCode::Char('q') => {
                        return Ok(false)
                    },
                    _ => {},
                },
                _ => {},
            }
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    enable_raw_mode()?;

    let mut stderr = std::io::stderr(); // This is a special case. Normally using stdout is fine.
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
