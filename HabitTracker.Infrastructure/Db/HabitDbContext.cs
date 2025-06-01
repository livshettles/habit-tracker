using HabitTracker.Domain.Entities.Habits;
using HabitTracker.Domain.Entities.Recipes;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Infrastructure.Db;

public class HabitDbContext(DbContextOptions<HabitDbContext> options) : DbContext(options)
{
    public DbSet<Habit> Habits => Set<Habit>();
    public DbSet<HabitCheckin> HabitCheckins => Set<HabitCheckin>();

    public DbSet<Recipe> Recipes => Set<Recipe>(); // 🍳 Add this!

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Recipe>()
            .Property(r => r.Ingredients)
            .HasConversion(
                v => string.Join("||", v),
                v => v.Split("||", StringSplitOptions.RemoveEmptyEntries).ToList()
            );

        modelBuilder.Entity<Recipe>()
            .Property(r => r.Tags)
            .HasConversion(
                v => string.Join(",", v),
                v => v.Split(",", StringSplitOptions.RemoveEmptyEntries).ToList()
            );
    }
}
