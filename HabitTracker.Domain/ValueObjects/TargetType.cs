namespace HabitTracker.Domain.ValueObjects;

/// <summary>
/// Represents a specific type of target that a note can be attached to (e.g., Habit, Dream, Recipe).
/// This class is a strongly-typed value object used to enforce valid and consistent target types.
/// </summary>
public sealed class TargetType : IEquatable<TargetType>
{

    public static readonly TargetType None = new("None");
    public static readonly TargetType Habit = new("Habit");
    public static readonly TargetType Dream = new("Dream");
    public static readonly TargetType Recipe = new("Recipe");
    public static readonly TargetType Reflection = new("Reflection");

    private static readonly HashSet<string> ValidValues =
    [
        None.Value,
        Habit.Value,
        Dream.Value,
        Recipe.Value,
        Reflection.Value
    ];

    /// <summary>
    /// Gets the string value of the target type (e.g., "Habit", "Dream").
    /// </summary>
    public string Value { get; }

    /// <summary>
    /// Initializes a new instance of the <see cref="TargetType"/> class with the specified string value.
    /// This constructor is private to enforce controlled instantiation through predefined values or the explicit cast.
    /// </summary>
    /// <param name="value">The string value of the target type.</param>
    private TargetType(string value)
    {
        Value = value;
    }

    /// <summary>
    /// Returns the string representation of the target type.
    /// </summary>
    public override string ToString() => Value;

    /// <summary>
    /// Determines whether the specified <see cref="TargetType"/> is equal to the current instance.
    /// </summary>
    /// <param name="other">The other <see cref="TargetType"/> to compare with.</param>
    public bool Equals(TargetType? other) =>
        other is not null && Value == other.Value;

    /// <summary>
    /// Determines whether the specified object is equal to the current <see cref="TargetType"/>.
    /// </summary>
    /// <param name="obj">The object to compare with the current instance.</param>
    public override bool Equals(object? obj) =>
        obj is TargetType other && Equals(other);

    /// <summary>
    /// Returns the hash code for this <see cref="TargetType"/>.
    /// </summary>
    public override int GetHashCode() => Value.GetHashCode();

    /// <summary>
    /// Performs an explicit conversion from a string to a <see cref="TargetType"/>.
    /// Throws an exception if the value is not a recognized target type.
    /// </summary>
    /// <param name="value">The string value to convert.</param>
    /// <returns>A <see cref="TargetType"/> corresponding to the input string.</returns>
    /// <exception cref="ArgumentException">Thrown when the string is not a valid target type.</exception>
    public static explicit operator TargetType(string value)
    {
        if (!ValidValues.Contains(value))
            throw new ArgumentException($"Invalid TargetType: '{value}'");

        return new TargetType(value);
    }

    /// <summary>
    /// Attempts to parse a string into a <see cref="TargetType"/> without throwing an exception.
    /// </summary>
    /// <param name="value">The string to parse.</param>
    /// <param name="result">When this method returns, contains the resulting <see cref="TargetType"/> if the parse was successful; otherwise, null.</param>
    /// <returns><c>true</c> if the string was successfully parsed into a valid <see cref="TargetType"/>; otherwise, <c>false</c>.</returns>
    public static bool TryParse(string value, out TargetType result)
    {
        if (ValidValues.Contains(value))
        {
            result = new TargetType(value);
            return true;
        }

        result = null!;
        return false;
    }

    /// <summary>
    /// Performs an implicit conversion from a <see cref="TargetType"/> to a <see cref="string"/>.
    /// </summary>
    /// <param name="type">The <see cref="TargetType"/> to convert.</param>
    /// <returns>The string value of the target type.</returns>
    public static implicit operator string(TargetType type) => type.Value;
}
