using HabitTracker.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Infrastructure.Db;

public class HabitDbContext : DbContext
{
    public HabitDbContext(DbContextOptions<HabitDbContext> options) : base(options) { }

    public DbSet<Habit> Habits => Set<Habit>();
    public DbSet<HabitCheckin> HabitCheckins => Set<HabitCheckin>();
}
