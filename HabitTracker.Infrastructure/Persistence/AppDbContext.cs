using HabitTracker.Domain.Common;
using HabitTracker.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace HabitTracker.Infrastructure.Persistence;

public class AppDbContext : DbContext
{
    public DbSet<Note> Notes => Set<Note>();
    public DbSet<Recipe> Recipes => Set<Recipe>();
    public DbSet<Habit> Habits => Set<Habit>();

    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configure value object: EntryMetadata
        modelBuilder.Entity<Note>().OwnsOne(n => n.Entry);
        modelBuilder.Entity<Recipe>().OwnsOne(r => r.Entry);
        modelBuilder.Entity<Habit>().OwnsOne(h => h.Entry);

        // Global query filter for soft deletes
        foreach (var entityType in modelBuilder.Model.GetEntityTypes())
        {
            if (typeof(ISoftDeletable).IsAssignableFrom(entityType.ClrType))
            {
                modelBuilder.Entity(entityType.ClrType)
                    .HasQueryFilter(GetIsDeletedFilter(entityType.ClrType));
            }
        }
    }

    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        var now = DateTime.UtcNow;

        foreach (var entry in ChangeTracker.Entries<IAuditable>())
        {
            if (entry.State == EntityState.Added)
                entry.Entity.CreateDate = now;

            if (entry.State == EntityState.Modified)
                entry.Entity.ModifiedDate = now;
        }

        return base.SaveChangesAsync(cancellationToken);
    }

    private static LambdaExpression GetIsDeletedFilter(Type entityType)
    {
        var parameter = Expression.Parameter(entityType, "e");
        var prop = Expression.Property(parameter, nameof(ISoftDeletable.IsDeleted));
        var condition = Expression.Equal(prop, Expression.Constant(false));
        return Expression.Lambda(condition, parameter);
    }
}
