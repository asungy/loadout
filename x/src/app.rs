use ratatui::crossterm;
pub enum Screen {
    FirstQuestion,
}

pub struct State {
    pub current_screen: Screen,
}

impl Default for State {
    fn default() -> Self {
        State {
            current_screen: Screen::FirstQuestion,
        }
    }
}

pub fn run(terminal: &mut ratatui::Terminal<impl ratatui::backend::Backend>) -> anyhow::Result<()> {
    let mut state = State::default();

    loop {
        terminal.draw(|f| crate::ui::render(f, &mut state))?;
        if let crossterm::event::Event::Key(key) = crossterm::event::read()? {
            if key.kind == crossterm::event::KeyEventKind::Release {
                continue;
            }

            match key.code {
                crossterm::event::KeyCode::Char('q') => {
                    return Ok(())
                },
                _ => {},
            }
        }
    }
}
