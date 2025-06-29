namespace HabitTracker.API.Models.Notes;

public class CreateNoteDto
{
    public string? Title { get; set; }
    public string Content { get; set; } = string.Empty;
    public string CreateUserId { get; set; } = string.Empty;
    public string Category { get; set; } = "General";
}

public class CreateAttachedNoteDto : CreateNoteDto
{
    public Guid TargetId { get; set; }
    public string TargetType { get; set; } = string.Empty;
}
