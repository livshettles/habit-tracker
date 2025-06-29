using HabitTracker.Domain.Common;

namespace HabitTracker.Domain.ValueObjects;

public class EntryMetadata : IAuditable, ISoftDeletable
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public string? Title { get; set; }

    public string Content { get; set; } = string.Empty;

    public DateTime CreateDate { get; set; } = DateTime.UtcNow;

    public DateTime? ModifiedDate { get; set; }

    public string CreateUserId { get; set; } = string.Empty;

    public bool IsDeleted { get; set; }
}
