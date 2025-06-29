namespace HabitTracker.Domain.ValueObjects;

public class EntryMetadata
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public string? Title { get; set; }

    public string Content { get; set; } = string.Empty;

    public DateTime CreateDate { get; set; } = DateTime.UtcNow;

    public string CreateUserId { get; set; } = string.Empty;

    public bool IsEmpty() =>
        string.IsNullOrWhiteSpace(Content);
}
