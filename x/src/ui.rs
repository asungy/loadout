use ratatui::{layout::{Constraint, Direction, Layout}, style::{Color, Style}, text::{Line, Span}, widgets::{List, ListItem}};


// helper function to create a centered rect using up certain percentage of the available rect 'r'.
fn centered_rect(percent_x: u16, percent_y: u16, r: ratatui::layout::Rect) -> ratatui::layout::Rect {
    // Cut the given rectangle into three vertical pieces.
    let popup_layout = Layout::default()
        .direction(Direction::Vertical)
        .constraints([
            Constraint::Percentage((100 - percent_y) / 2),
            Constraint::Percentage(percent_y),
            Constraint::Percentage((100 - percent_y) / 2),
        ])
        .split(r);

    // Then cut the middle vertical piece into three width-wise pieces.
    Layout::default()
        .direction(Direction::Horizontal)
        .constraints([
            Constraint::Percentage((100 - percent_y) / 2),
            Constraint::Percentage(percent_y),
            Constraint::Percentage((100 - percent_y) / 2),
        ])
        .split(popup_layout[1])[1] // Return the middle chunk
}

pub fn ui(frame: &mut ratatui::Frame, app: &crate::app::App) {
    let chunks = Layout::default()
        .direction(Direction::Vertical)
        .constraints([
            Constraint::Length(3),
            Constraint::Min(1),
            Constraint::Length(3),
        ])
        .split(frame.area());

    let title_block = ratatui::widgets::Block::default()
        .borders(ratatui::widgets::Borders::ALL)
        .style(Style::default());

    let title = ratatui::widgets::Paragraph::new(ratatui::text::Text::styled(
        "Create New JSON",
        Style::default().fg(Color::Green),
    )).block(title_block);

    frame.render_widget(title, chunks[0]);

    let mut list_items = Vec::<ListItem>::new();

    for key in app.pairs.keys() {
        list_items.push(ListItem::new(Line::from(Span::styled(
            format!("{: <25} : {}", key, app.pairs.get(key).unwrap()),
            Style::default().fg(Color::Yellow),
        ))));
    }

    let list = List::new(list_items);

    frame.render_widget(list, chunks[1]);

    // LEFT OFF: https://ratatui.rs/tutorials/json-editor/ui-main/
    // The bottom navigation bar.
}
