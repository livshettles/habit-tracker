namespace HabitTracker.Domain.Entities;

public class HabitCheckin
{
    public Guid Id { get; set; }
    public Guid HabitId { get; set; }
    public DateTime Date { get; set; }
}
