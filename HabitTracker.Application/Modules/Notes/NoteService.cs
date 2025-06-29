using HabitTracker.Domain.Entities;
using HabitTracker.Domain.Repositories;
using HabitTracker.Domain.ValueObjects;

namespace HabitTracker.Application.Notes;

public class NoteService : INoteService
{
    private readonly INoteRepository _repository;

    public NoteService(INoteRepository repository)
    {
        _repository = repository;
    }

    public async Task<Note> CreateAsync(NoteRequestModel model, string userId)
    {
        var note = new Note(userId, model.Title, model.Content);
        await _repository.AddAsync(note);
        return note;
    }

    public async Task<Note> UpdateAsync(NoteRequestModel model)
    {
        var note = await _repository.GetByIdAsync(model.Id!.Value);
        if (note is null)
            throw new InvalidOperationException("Note not found.");

        note.UpdateContent(model.Title, model.Content);
        await _repository.UpdateAsync(note);
        return note;
    }

    public Task<Note?> GetByIdAsync(Guid id) =>
        _repository.GetByIdAsync(id);

    public async Task DeleteAsync(Guid id)
    {
        var note = await _repository.GetByIdAsync(id);
        if (note is not null)
        {
            // note.Delete(); // TO DO Soft delete
            await _repository.DeleteAsync(note);
        }
    }
}
