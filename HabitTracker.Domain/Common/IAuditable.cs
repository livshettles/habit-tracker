namespace HabitTracker.Domain.Common;

public interface IAuditable
{
    DateTime CreateDate { get; set; }
    DateTime? ModifiedDate { get; set; }
}