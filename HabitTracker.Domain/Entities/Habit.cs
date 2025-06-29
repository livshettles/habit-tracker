using HabitTracker.Domain.ValueObjects;

namespace HabitTracker.Domain.Entities;

public class Habit
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public EntryMetadata Entry { get; set; } = new();

    public DateTime StartDate { get; set; } = DateTime.UtcNow;

    public string Frequency { get; set; } = "Daily";

    // public List<string> Tags { get; set; } = [];

    public bool IsArchived { get; set; } = false;

    public List<EntryMetadata> CheckIns { get; set; } = [];
}
