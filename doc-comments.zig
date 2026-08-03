/// A structure for storing a timestamp, with nanosecond precision (this is a
/// doc comment, so it will be included in the generated documentation).
const Timestamp = struct {
    /// the number of seconds since the epoch (January 1, 1970).
    seconds: i64, // signed so we can represent negative timestamps (before the epoch)
    /// the number of nanoseconds since the last second.
    nanos: u32,

    ///Returns a timestamp struct representing the current time.
    /// moment in the future, this will be replaced with a more precise implementation.
    pub fn unixEpoch() Timestamp {
        return Timestamp{
            .seconds = 0,
            .nanos = 0,
        };
    }
};
