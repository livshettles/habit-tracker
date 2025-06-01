using HabitTracker.Application.DTOs;
using HabitTracker.Application.Interfaces;
using HabitTracker.Domain.Entities.Habits;
using HabitTracker.Infrastructure.Db;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Infrastructure.Services;

public class HabitService(HabitDbContext db) : IHabitService
{
    public async Task<IEnumerable<HabitDto>> GetHabitsAsync(Guid userId)
    {
        return await db.Habits
            .Where(h => h.UserId == userId)
            .Select(h => new HabitDto
            {
                Id = h.Id,
                Name = h.Name,
                Checkins = h.Checkins.Select(c => c.Date).ToList()
            })
            .ToListAsync();
    }

    public async Task<HabitDto> CreateHabitAsync(CreateHabitDto dto)
    {
        var habit = new Habit
        {
            Id = Guid.NewGuid(),
            Name = dto.Name,
            UserId = dto.UserId,
            CreatedAt = DateTime.UtcNow
        };

        db.Habits.Add(habit);
        await db.SaveChangesAsync();

        return new HabitDto { Id = habit.Id, Name = habit.Name };
    }

    public async Task<bool> CheckinHabitAsync(Guid habitId, DateTime date)
    {
        var checkin = new HabitCheckin { Id = Guid.NewGuid(), HabitId = habitId, Date = date.Date };
        db.HabitCheckins.Add(checkin);
        await db.SaveChangesAsync();
        return true;
    }
}
