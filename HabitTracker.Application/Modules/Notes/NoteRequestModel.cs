namespace HabitTracker.Application.Notes;

public class NoteRequestModel
{
    public Guid? Id { get; set; }  // Optional for create, required for update
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
}
