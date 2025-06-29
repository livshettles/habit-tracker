using HabitTracker.Domain.Entities;
using HabitTracker.Domain.Repositories;
using HabitTracker.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Infrastructure.Repositories;

public class NoteRepository : INoteRepository
{
    private readonly AppDbContext _context;

    public NoteRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddAsync(Note note)
    {
        _context.Notes.Add(note);
        await _context.SaveChangesAsync();
    }

    public async Task<Note?> GetByIdAsync(Guid id)
    {
        return await _context.Notes.FindAsync(id);
    }

    public async Task UpdateAsync(Note note)
    {
        _context.Notes.Update(note);
        await _context.SaveChangesAsync();
    }

    public async Task DeleteAsync(Note note)
    {
        _context.Notes.Update(note); // Just updating soft-delete flag
        await _context.SaveChangesAsync();
    }
}
