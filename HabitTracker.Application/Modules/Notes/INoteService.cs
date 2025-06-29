using HabitTracker.Application.Notes;
using HabitTracker.Domain.Entities;

namespace HabitTracker.Application.Notes;

public interface INoteService
{
    Task<Note> CreateAsync(NoteRequestModel model, string userId);
    Task<Note> UpdateAsync(NoteRequestModel model);
    Task<Note?> GetByIdAsync(Guid id);
    Task DeleteAsync(Guid id);
}