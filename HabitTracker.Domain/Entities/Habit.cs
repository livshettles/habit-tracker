namespace HabitTracker.Domain.Entities;

public class Habit
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public Guid UserId { get; set; }
    public DateTime CreatedAt { get; set; }
    public ICollection<HabitCheckin> Checkins { get; set; } = new List<HabitCheckin>();
}
