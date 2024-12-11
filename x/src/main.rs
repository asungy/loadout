#![allow(clippy::all, missing_debug_implementations)]

mod app;
mod ui;

use ratatui::crossterm;

fn main() -> anyhow::Result<()> {
    // Set up terminal.
    crossterm::terminal::enable_raw_mode()?;
    let mut terminal = {
        let mut stdout = std::io::stdout();
        ratatui::crossterm::execute!(
            stdout,
            crossterm::terminal::EnterAlternateScreen,
            crossterm::event::EnableMouseCapture,
        )?;
        let backend = ratatui::backend::CrosstermBackend::new(stdout);
        ratatui::Terminal::new(backend)?
    };

    // Run application.
    app::run(&mut terminal)?;

    // Restore terminal.
    {
        crossterm::terminal::disable_raw_mode()?;
        ratatui::crossterm::execute!(
            terminal.backend_mut(),
            crossterm::terminal::LeaveAlternateScreen,
            crossterm::event::DisableMouseCapture,
        )?;
        terminal.show_cursor()?;
    }

    Ok(())
}
