namespace HabitTracker.Application.DTOs;

public class CreateHabitDto
{
    public string Name { get; set; } = string.Empty;
    public Guid UserId { get; set; }
}
