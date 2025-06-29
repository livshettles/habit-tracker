using HabitTracker.Domain.Common;
using HabitTracker.Domain.ValueObjects;

namespace HabitTracker.Domain.Entities;

public class Note : IAuditable, ISoftDeletable
{
    protected Note() { }

    public Note(string createUserId, string title, string content)
    {
        Entry = new EntryMetadata
        {
            Title = title,
            Content = content,
            CreateUserId = createUserId,
            CreateDate = DateTime.UtcNow
        };
    }

    public Guid Id { get; private set; } = Guid.NewGuid();

    public EntryMetadata Entry { get; private set; } = new();

    public bool IsDeleted { get; set; }
    public DateTime CreateDate { get; set; }
    public DateTime? ModifiedDate { get; set; }

    public void UpdateContent(string title, string content)
    {
        if (string.IsNullOrWhiteSpace(content))
            throw new Exception("Note content cannot be empty.");

        Entry.Title = title;
        Entry.Content = content;
    }

    public void Delete()
    {
        IsDeleted = true;
    }
}
