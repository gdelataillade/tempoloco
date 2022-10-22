const List<String> supportedLanguages = [
  "en",
  "fr",
  "es",
];

const List<String> stupidPasswords = [
  "password",
  "123456",
  "qwerty",
  "azerty",
  "000000",
  "123456789",
  "1234567890",
  "qwertyuiop",
];

List<Map<String, dynamic>> onboardingGenres = [
  {
    "genre": "Pop",
    "artistPictureUrl":
        "https://i.scdn.co/image/ab6761610000f178a2a0b9e3448c1e702de9dc90",
    "tracks": [
      {
        "title": "2Foc5Q5nqNiosCNqttzHof", // Get Lucky
        "artist": "4tZwfgrHOc3mvqYlEYSvVi", // Daft Punk
      },
      {
        "title": "7qiZfU4dY1lWllzX7mPBI3", // Shape of You
        "artist": "6eUKZXaKkcviH0Ku9w2n3V", // Ed Sheeran
      },
      {
        "title": "32OlwWuMpZ6b0aN2RZOeMS", // Uptown Funk
        "artist": "3hv9jJF3adDNsBSIQDqcjp", // Mark Ronson
      },
      {
        "title": "6ggAYREO7PlFwI2vbOG3dp", // She Moves
        "artist": "61ipISvUVa5LkJlKZnm3Oo", // Alle Farben
      },
      {
        "title": "7azo4rpSUh8nXgtonC6Pkq", // Thriller
        "artist": "3fMbdgg4jU18AjLCKBhRSm", // Michael Jackson
      },
      {
        "title": "1EzrEOXmMH3G43AXT1y7pA", // I'm yours
        "artist": "4phGZZrJZRo4ElhRtViYdl", // Jason Mraz
      },
    ],
  },
  {
    "genre": "Electro",
    "artistPictureUrl":
        "https://i.scdn.co/image/ab6761610000f17875348e1aade2645ad9c58829",
    "tracks": [
      {
        "title": "1TWfkGrhF7ob0nwB2M6knb", // Animals
        "artist": "60d24wfXkVzDSfLS6hyCjZ", // Martin Garrix
      },
      {
        "title": "2XU0oxnq2qxCpomAAuJY8K", // Dance Monkey
        "artist": "2NjfBq1NflQcKSeiDooVjY", // Tones and I
      },
      {
        "title": "0lHAMNU8RGiIObScrsRgmP", // Titanium
        "artist": "1Cs0zKBU1kc0i8ypK3B9ai", // David Guetta
      },
      {
        "title": "33yAEqzKXexYM3WlOYtTfQ", // D.A.N.C.E
        "artist": "1gR0gsQYfi6joyO1dlp76N", // Justice
      },
    ],
  },
  {
    "genre": "Rock",
    "artistPictureUrl":
        "https://i.scdn.co/image/ab6761610000f17831f6ab67e6025de876475814",
    "tracks": [
      {
        "title": "2aoo2jlRnM3A0NyLQqMN2f", // All Along the Watchtower
        "artist": "776Uo845nYHJpNaStv1Ds4", // Jimi Hendrix
      },
      {
        "title": "2RlgNHKcydI9sayD2Df2xp", // Mr Blue Sky
        "artist": "7jefIIksOi1EazgRTfW2Pk", // Electric Light Orchestra
      },
      {
        "title": "40riOy7x9W7GXjyGp4pjAv", // Hotel California
        "artist": "0ECwFtbIWEVNwjlrfc6xoL", // Eagles
      },
      {
        "title": "39shmbIHICJ2Wxnk1fPSdz", // Should I stay or should I go
        "artist": "3RGLhK1IP9jnYFH4BRFJBS", // The Clash
      },
    ],
  },
  {
    "genre": "Rap",
    "artistPictureUrl":
        "https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b",
    "tracks": [
      {
        "title": "45KqDHTOJtIM53QR1gPGTa", // Brothers
        "artist": "6pdcQa7by8IKuoVXvgknlI", // Riles
      },
      {
        "title": "4WB9OeauHXnGOMUK4s80gM", // Trop beau
        "artist": "1Yfe3ONJlioHys7jwHdfVm", // Lomepal
      },
      {
        "title": "7lhuM9WUqdThw72dCBRmQW", // Reves bizarres
        "artist": "4FpJcNgOvIpSBeJgRg3OfN", // Orelsan
      },
      {
        "title": "2amrInRmNzmt4Etb6Yn1er", // Cote Ouest
        "artist": "0aXaZj4wB5jLF2E2d8WEVi", // 47ter
      },
    ],
  },
  {
    "genre": "Metal",
    "artistPictureUrl":
        "https://i.scdn.co/image/ab6761610000f1788101d13bdd630b0889acd2fd",
    "tracks": [
      {
        "title": "0snQkGI5qnAmohLE7jTsTn", // Toxicity
        "artist": "5eAWCfyUhZtHHtBdNk56l1", // System of a down
      },
      {
        "title": "57bgtoPSgt236HzfBOd8kj", // Thunderstruck
        "artist": "711MCceyCBcFnzjGY4Q7Un", // AC/DC
      },
      {
        "title": "5BIMPccDwShpXq784RJlJp", // Enter Sandman
        "artist": "2ye2Wgw4gimLv2eAKyk1NB", // Metallica
      },
      {
        "title": "61mWefnWQOLf90gepjOCb3", // Duality
        "artist": "05fG473iIaoy82BF1aGhL8", // Slipknot
      },
    ],
  },
  {
    "genre": "Raggae",
    "artistPictureUrl":
        "https://i.scdn.co/image/aa79350754a8e9ef651229e7cc5a6d127940c8df",
    "tracks": [
      {
        "title": "0bu5oNxU5pdQuFGxT4gwNr", // Chase the devil
        "artist": "1TsG4AumsMt1Tcq2nHpov9", // Lee Scratch Perry
      },
      {
        "title": "2OHQhOiGIYaXqqJVIMpNrF", // Kingston Town
        "artist": "78u1jLVBjPSXQVmHBV43yG", // Alborosie
      },
      {
        "title": "73lYI49LhfsscO33ohrGN0", // Legalize It
        "artist": "0oea1hwGMfUxZbLxJc1XUN", // Peter Tosh
      },
      {
        "title": "0mD19MC6H0OzHvEUADHypU", // Police in Helicopter
        "artist": "312pFk2xpEwYWLGPehc4Nu", // John Holt
      },
    ],
  },
];

// Copy a famous Spotify playlist
// Get id and add it here
const List<Map<String, String>> playlists = [
  {
    "name": "Best of Rock: 1970",
    "id": "37i9dQZF1DXe9Gx5fVy1RT",
  },
];
