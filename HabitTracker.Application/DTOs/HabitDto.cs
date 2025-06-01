namespace HabitTracker.Application.DTOs
{
    public class HabitDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; } = "";
        public List<DateTime> Checkins { get; set; } = new();
    }

}
