use crate::prompt::Prompt;

pub fn f() -> anyhow::Result<Option<Prompt>> {
    crate::core::home_manager::build()?;
    Ok(None)
}
