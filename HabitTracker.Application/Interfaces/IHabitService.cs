using HabitTracker.Application.DTOs;

namespace HabitTracker.Application.Interfaces;

public interface IHabitService
{
    Task<IEnumerable<HabitDto>> GetHabitsAsync(Guid userId);
    Task<HabitDto> CreateHabitAsync(CreateHabitDto dto);
    Task<bool> CheckinHabitAsync(Guid habitId, DateTime date);
}
