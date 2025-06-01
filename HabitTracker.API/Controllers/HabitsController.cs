using HabitTracker.Application.DTOs;
using HabitTracker.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace HabitTracker.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HabitsController(IHabitService habitService) : ControllerBase
{
    [HttpGet("{userId}")]
    public async Task<IActionResult> Get(Guid userId)
    {
        var habits = await habitService.GetHabitsAsync(userId);
        return Ok(habits);
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateHabitDto dto)
    {
        var habit = await habitService.CreateHabitAsync(dto);
        return Ok(habit);
    }

    [HttpPost("{habitId}/checkin")]
    public async Task<IActionResult> Checkin(Guid habitId, [FromQuery] DateTime date)
    {
        await habitService.CheckinHabitAsync(habitId, date);
        return Ok();
    }
}
