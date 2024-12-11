pub fn render(frame: &mut ratatui::Frame, state: &mut crate::app::State) {
    match state.current_screen {
        crate::app::Screen::FirstQuestion => {
            let sections = ratatui::layout::Layout::default()
                .direction(ratatui::layout::Direction::Vertical)
                .constraints([
                    ratatui::layout::Constraint::Length(3),
                    ratatui::layout::Constraint::Min(3),
                ])
                .split(frame.area());

            let title = ratatui::text::Line::from(vec![
                ratatui::text::Span::styled(
                    "What would you like to do?",
                    ratatui::style::Style::default()
                        .add_modifier(ratatui::style::Modifier::BOLD),
                ),
            ]);
            frame.render_widget(title, sections[0]);

            let options = ratatui::widgets::List::new([
                "Build an existing machine (1)",
                "Build a new machine (2)",
            ]);
            frame.render_widget(options, sections[1]);
            // LEFT OFF: Maybe format current ui to use block:
            // https://ratatui.rs/showcase/widgets/
            //
            // Figure out how to center things.
        },
    }
}
