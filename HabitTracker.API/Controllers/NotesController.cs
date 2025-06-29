using HabitTracker.API.Models.Notes;
using HabitTracker.Application.Notes;
using HabitTracker.Domain.Entities;
using HabitTracker.Domain.ValueObjects;
using Microsoft.AspNetCore.Mvc;

namespace HabitTracker.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class NotesController : ControllerBase
{
    private readonly INoteService _noteService;

    public NotesController(INoteService noteService)
    {
        _noteService = noteService;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] NoteRequestModel model)
    {
        // await _createValidator.ValidateAndThrowAsync(model);
        var userId = "livshettles"; // TODO remove
        var note = await _noteService.CreateAsync(model, userId);
        return Ok(note);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] NoteRequestModel model)
    {
        model.Id = id;
        // await _updateValidator.ValidateAndThrowAsync(model);
        var note = await _noteService.UpdateAsync(model);
        return Ok(note);
    }

    [HttpGet("{id}")]
    public IActionResult Get(Guid id)
    {
        // var note = await _noteService.GetByIdAsync(id);
        var note = new Note("livshettles", string.Empty, string.Empty);

        return note is null ? NotFound() : Ok(note);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        await _noteService.DeleteAsync(id);
        return NoContent();
    }
}

