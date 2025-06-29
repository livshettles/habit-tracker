using HabitTracker.Domain.Entities;

namespace HabitTracker.Domain.Repositories;

public interface INoteRepository
{
    Task<Note?> GetByIdAsync(Guid id);
    Task AddAsync(Note note);
    Task UpdateAsync(Note note);
    Task DeleteAsync(Note note);
}
