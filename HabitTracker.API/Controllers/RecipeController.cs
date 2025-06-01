using HabitTracker.Domain.Entities.Recipes;
using HabitTracker.Infrastructure.Db;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RecipeController(HabitDbContext context) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() =>
        Ok(await context.Recipes.ToListAsync());

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] Recipe recipe)
    {
        context.Recipes.Add(recipe);
        await context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetById), new { id = recipe.Id }, recipe);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(Guid id)
    {
        var recipe = await context.Recipes.FindAsync(id);
        return recipe is null ? NotFound() : Ok(recipe);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] Recipe updated)
    {
        var recipe = await context.Recipes.FindAsync(id);
        if (recipe is null) return NotFound();

        recipe.Title = updated.Title;
        recipe.Ingredients = updated.Ingredients;
        recipe.Instructions = updated.Instructions;
        recipe.Tags = updated.Tags;
        await context.SaveChangesAsync();
        return NoContent();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var recipe = await context.Recipes.FindAsync(id);
        if (recipe is null) return NotFound();

        context.Recipes.Remove(recipe);
        await context.SaveChangesAsync();
        return NoContent();
    }
}
