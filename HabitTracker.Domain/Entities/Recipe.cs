using HabitTracker.Domain.ValueObjects;

namespace HabitTracker.Domain.Entities;

public class Recipe
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public EntryMetadata Entry { get; set; } = new();

    public string Category { get; set; } = "Uncategorized";

    public List<string> Tags { get; set; } = [];

    public bool IsFavorite { get; set; } = false;

    public bool IsArchived { get; set; } = false;
}
