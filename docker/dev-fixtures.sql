-- Deterministic local-development data for OMDB.
--
-- This file intentionally uses plain INSERT statements. Loading it into a
-- non-empty database should fail rather than overwrite existing data.

SET NAMES utf8mb4;
SET time_zone = '+00:00';

START TRANSACTION;

INSERT INTO users (
    UserID, Username, banned, Weight, LastAccessedSite, HideRatings,
    UserTitle, OnlyFriendsOnFrontPage, moderator, IsPrivate
) VALUES
    (9558549, 'moonpoint', 0, 1.0000, '2026-08-20 12:00:00', 0, 'Local administrator', 0, 1, 0),
    (9900001, 'FixtureMapper', 0, 1.0000, '2026-08-20 12:00:00', 0, 'Mapper', 0, 0, 0),
    (9900002, 'FixtureReviewer', 0, 1.0000, '2026-08-20 12:00:00', 0, 'Reviewer', 0, 0, 0),
    (9900003, 'FixtureRaterA', 0, 1.0000, '2026-08-20 12:00:00', 0, NULL, 0, 0, 0),
    (9900004, 'FixtureRaterB', 0, 1.0000, '2026-08-20 12:00:00', 0, NULL, 0, 0, 0);

INSERT INTO mappernames (UserID, Username, Country) VALUES
    (9558549, 'moonpoint', 'US'),
    (9900001, 'FixtureMapper', 'GB'),
    (9900002, 'FixtureReviewer', 'CA'),
    (9900003, 'FixtureRaterA', 'DE'),
    (9900004, 'FixtureRaterB', 'JP');

INSERT INTO sessions (
    SessionToken, UserID, ExpiresAt, LastAccessedAt, IpAddress, DeviceInfo
) VALUES (
    'omdb-local-moonpoint', 9558549, '2099-01-01 00:00:00',
    '2026-08-20 12:00:00', '127.0.0.1', 'Local development session'
);

INSERT INTO descriptors (
    DescriptorID, Name, ShortDescription, ParentID, Usable, LongDescription
) VALUES
    (910001, 'Fixture Style', 'Synthetic descriptors for local development.', NULL, 0, 'A local-only descriptor category.'),
    (910002, 'Fixture Flow', 'Consistent movement between objects.', 910001, 1, 'A synthetic flow descriptor for local development.'),
    (910003, 'Fixture Rhythm', 'Distinct rhythmic patterns.', 910001, 1, 'A synthetic rhythm descriptor for local development.'),
    (910004, 'Fixture Aim', 'Aim-focused patterns.', 910001, 1, 'A synthetic aim descriptor for local development.');

INSERT INTO beatmap_roles (RoleID, Name, ShortDescription) VALUES
    (9001, 'Mapper', 'Contributed to the map layout.');

INSERT INTO beatmapsets (
    SetID, CreatorID, Status, Timestamp, Genre, Lang, Artist, Title,
    DateRanked, HasStoryboard, HasVideo, CreatorName, IsNSFW,
    SearchText, SearchIDs, MaxRating, ModeMask
) VALUES
    (900001, 9900001, 1, '2026-08-18 09:00:00', 10, 2, 'Fixture Artist', 'Fixture Sunrise', '2024-06-15 12:00:00', 1, 0, 'FixtureMapper', 0, 'Fixture Artist Fixture Sunrise Fixture Insane Fixture Hard FixtureMapper', '900001,9000001,9000002,9900001', 5, 1),
    (900002, 9900001, 1, '2026-08-19 10:00:00', 3, 3, 'Sample Ensemble', 'Deterministic Sky', '2025-11-02 12:00:00', 0, 1, 'FixtureMapper', 0, 'Sample Ensemble Deterministic Sky Fixture Expert FixtureMapper', '900002,9000003,9900001', 5, 1),
    (900003, 9900004, 1, '2026-08-20 11:00:00', 2, 1, 'Local Composer', 'Database Dreams', '2023-03-20 12:00:00', 0, 0, 'FixtureRaterB', 0, 'Local Composer Database Dreams Fixture Normal FixtureRaterB', '900003,9000004,9900004', 3, 1);

INSERT INTO beatmaps (
    BeatmapID, SetID, DifficultyName, Mode, Status, SR, Rating, ChartRank,
    ChartYearRank, Timestamp, RatingCount, WeightedAvg, Blacklisted,
    controversy, ApproachRate, CircleSize, Drain, OverallDifficulty,
    CircleCount, SpinnerCount, SliderCount, PlayTime, LazerOnly, Bpm
) VALUES
    (9000001, 900001, 'Fixture Insane', 0, 1, 5.25, 4.00, 2, 1, '2026-08-18 09:00:00', 5, 4.00, 0, 0.71, 9.20, 4.00, 6.50, 8.50, 420, 3, 210, 185, 0, 175.00),
    (9000002, 900001, 'Fixture Hard', 0, 1, 3.75, 3.00, 3, 2, '2026-08-18 09:00:00', 5, 3.00, 0, 0.71, 8.00, 4.00, 5.50, 6.50, 300, 2, 160, 175, 0, 175.00),
    (9000003, 900002, 'Fixture Expert', 0, 1, 6.10, 4.50, 1, 1, '2026-08-19 10:00:00', 5, 4.50, 0, 0.45, 9.50, 4.00, 7.00, 9.00, 500, 4, 250, 205, 0, 190.00),
    (9000004, 900003, 'Fixture Normal', 0, 1, 2.20, 2.00, 4, 1, '2026-08-20 11:00:00', 5, 2.00, 0, 0.71, 6.50, 4.00, 4.00, 5.00, 180, 1, 90, 140, 0, 145.00);

INSERT INTO beatmap_creators (BeatmapID, CreatorID) VALUES
    (9000001, 9900001),
    (9000002, 9900001),
    (9000003, 9900001),
    (9000004, 9900004);

INSERT INTO beatmapset_nominators (SetID, NominatorID, Mode) VALUES
    (900001, 9900002, 0),
    (900002, 9900002, 0),
    (900003, 9900003, 0);

INSERT INTO beatmapset_credits (AssignmentID, SetID, MapID, RoleID, UserID) VALUES
    (9001, 900001, NULL, 9001, 9900003),
    (9002, 900002, 9000003, 9001, 9900002);

INSERT INTO ratings (RatingID, BeatmapID, UserID, Score, date) VALUES
    (900001, 9000001, 9558549, 5.0, '2026-08-20 08:00:00'),
    (900002, 9000001, 9900001, 4.5, '2026-08-20 08:05:00'),
    (900003, 9000001, 9900002, 4.0, '2026-08-20 08:10:00'),
    (900004, 9000001, 9900003, 3.5, '2026-08-20 08:15:00'),
    (900005, 9000001, 9900004, 3.0, '2026-08-20 08:20:00'),
    (900006, 9000002, 9558549, 4.0, '2026-08-20 08:25:00'),
    (900007, 9000002, 9900001, 3.5, '2026-08-20 08:30:00'),
    (900008, 9000002, 9900002, 3.0, '2026-08-20 08:35:00'),
    (900009, 9000002, 9900003, 2.5, '2026-08-20 08:40:00'),
    (900010, 9000002, 9900004, 2.0, '2026-08-20 08:45:00'),
    (900011, 9000003, 9558549, 5.0, '2026-08-20 09:00:00'),
    (900012, 9000003, 9900001, 5.0, '2026-08-20 09:05:00'),
    (900013, 9000003, 9900002, 4.5, '2026-08-20 09:10:00'),
    (900014, 9000003, 9900003, 4.0, '2026-08-20 09:15:00'),
    (900015, 9000003, 9900004, 4.0, '2026-08-20 09:20:00'),
    (900016, 9000004, 9558549, 3.0, '2026-08-20 10:00:00'),
    (900017, 9000004, 9900001, 2.5, '2026-08-20 10:05:00'),
    (900018, 9000004, 9900002, 2.0, '2026-08-20 10:10:00'),
    (900019, 9000004, 9900003, 1.5, '2026-08-20 10:15:00'),
    (900020, 9000004, 9900004, 1.0, '2026-08-20 10:20:00');

INSERT INTO rating_tags (TagID, UserID, BeatmapID, Tag) VALUES
    (9001, 9558549, 9000001, 'fixture'),
    (9002, 9900002, 9000003, 'recommended');

INSERT INTO beatmap_descriptors (id, BeatmapID, DescriptorID, Weight) VALUES
    (9001, 9000001, 910002, 5),
    (9002, 9000001, 910003, 3),
    (9003, 9000002, 910002, 3),
    (9004, 9000003, 910003, 5),
    (9005, 9000003, 910004, 4),
    (9006, 9000004, 910004, 3);

INSERT INTO descriptor_votes (VoteID, BeatmapID, UserID, Vote, DescriptorID) VALUES
    (9001, 9000001, 9558549, 1, 910002),
    (9002, 9000001, 9900002, 1, 910003),
    (9003, 9000003, 9900003, 1, 910004);

INSERT INTO user_relations (UserIDFrom, UserIDTo, type) VALUES
    (9558549, 9900001, 1),
    (9900001, 9558549, 1);

INSERT INTO comments (CommentID, UserID, SetID, Comment, date) VALUES
    (9001, 9900002, 900001, 'The first deterministic development comment.', '2026-08-20 10:30:00'),
    (9002, 9900003, 900002, 'Useful fixture data for testing activity feeds.', '2026-08-20 10:35:00');

INSERT INTO reviews (ReviewID, UserID, SetID, Comment, date) VALUES
    (9001, 9900003, 900001, 'A synthetic review with enough detail to exercise the review layout.', '2026-08-20 10:40:00'),
    (9002, 9900002, 900002, 'A second review for list and profile coverage.', '2026-08-20 10:45:00');

INSERT INTO lists (ListID, Title, Description, UserID, Private, CreatedAt) VALUES
    (9001, 'Local Development Picks', 'A deterministic list containing each supported item type.', 9900002, 0, '2026-08-20 11:00:00');

INSERT INTO list_items (ItemID, ListID, Type, SubjectID, Description, `order`) VALUES
    (9001, 9001, 'beatmapset', 900001, 'The primary fixture mapset.', 1),
    (9002, 9001, 'beatmap', 9000003, 'The highest-rated fixture difficulty.', 2),
    (9003, 9001, 'person', 9900001, 'The fixture mapper profile.', 3);

INSERT INTO list_hearts (HeartID, ListID, UserID, CreatedAt) VALUES
    (9001, 9001, 9900003, '2026-08-20 11:05:00');

INSERT INTO news_posts (NewsID, Title, Content, AuthorID, DateCreated) VALUES
    (9001, 'Local development database ready', 'This synthetic post confirms that development fixtures loaded successfully.', 9558549, '2026-08-20 11:10:00');

INSERT INTO news_comments (CommentID, UserID, NewsID, Comment, Timestamp) VALUES
    (9001, 9900002, 9001, 'The fixture news page is working.', '2026-08-20 11:15:00');

INSERT INTO news_hearts (HeartID, NewsID, UserID, CreatedAt) VALUES
    (9001, 9001, 9900003, '2026-08-20 11:20:00');

INSERT INTO forum_topics (TopicID, Name, Description, ParentID) VALUES
    (9001, 'Local Development', 'A topic populated by deterministic fixture data.', NULL);

INSERT INTO forum_threads (ThreadID, Title, TopicID, UserID, CreatedAt) VALUES
    (9001, 'Fixture discussion thread', 9001, 9558549, '2026-08-20 11:25:00');

INSERT INTO forum_posts (PostID, ThreadID, UserID, Content, CreatedAt) VALUES
    (9001, 9001, 9558549, 'This thread verifies the local forum data graph.', '2026-08-20 11:30:00'),
    (9002, 9001, 9900001, 'The fixture reply is also available.', '2026-08-20 11:35:00');

INSERT INTO tournament_series (SeriesID, Name, Acronym, CreatedAt) VALUES
    (9001, 'Local Development Series', 'LDS', '2026-08-20 11:40:00');

INSERT INTO tournaments (
    TournamentID, Name, Acronym, StartDate, EndDate, SeriesID, CreatedAt
) VALUES
    (9001, 'Fixture Cup 2026', 'FC26', '2026-08-01', '2026-08-31', 9001, '2026-08-20 11:45:00');

INSERT INTO tournament_stages (StageID, TournamentID, Name, Acronym, SortOrder) VALUES
    (201, 9001, 'Qualifiers', 'QF', 1);

INSERT INTO tournament_maps (
    BeatmapID, TournamentID, StageID, Slot, SortOrder, IsCustom
) VALUES
    (9000001, 9001, 201, 'NM1', 1, 0),
    (9000003, 9001, 201, 'NM2', 2, 0);

INSERT INTO cache (Attribute, Value) VALUES
    ('motd_0', '9000001'),
    ('dev_fixture_version', '1');

INSERT INTO cache_home_best_map (BeatmapID, Mode) VALUES
    (9000003, 0);

INSERT INTO cache_home_recent_maps (
    SetID, Timestamp, Metadata, CreatorID, Mode
) VALUES
    (900003, '2026-08-20 11:00:00', 'Local Composer - Database Dreams', 9900004, 0),
    (900002, '2026-08-19 10:00:00', 'Sample Ensemble - Deterministic Sky', 9900001, 0),
    (900001, '2026-08-18 09:00:00', 'Fixture Artist - Fixture Sunrise', 9900001, 0);

COMMIT;
