const List<String> supportedLanguages = [
  'en',
  'fr',
  'es',
];

const List<String> stupidPasswords = [
  'password',
  '123456',
  'qwerty',
  'azerty',
  '000000',
  '123456789',
  '1234567890',
  'qwertyuiop',
];

List<Map<String, dynamic>> onboardingGenres = [
  {
    'genre': 'Pop',
    'artistPictureUrl':
        'https://i.scdn.co/image/ab6761610000f178a2a0b9e3448c1e702de9dc90',
    'tracks': [
      {
        'title': '2Foc5Q5nqNiosCNqttzHof', // Get Lucky
        'artist': '4tZwfgrHOc3mvqYlEYSvVi', // Daft Punk
      },
      {
        'title': '7qiZfU4dY1lWllzX7mPBI3', // Shape of You
        'artist': '6eUKZXaKkcviH0Ku9w2n3V', // Ed Sheeran
      },
      {
        'title': '32OlwWuMpZ6b0aN2RZOeMS', // Uptown Funk
        'artist': '3hv9jJF3adDNsBSIQDqcjp', // Mark Ronson
      },
      {
        'title': '6ggAYREO7PlFwI2vbOG3dp', // She Moves
        'artist': '61ipISvUVa5LkJlKZnm3Oo', // Alle Farben
      },
      {
        'title': '7azo4rpSUh8nXgtonC6Pkq', // Thriller
        'artist': '3fMbdgg4jU18AjLCKBhRSm', // Michael Jackson
      },
      {
        'title': '1EzrEOXmMH3G43AXT1y7pA', // I'm yours
        'artist': '4phGZZrJZRo4ElhRtViYdl', // Jason Mraz
      },
      {
        'title': '32OlwWuMpZ6b0aN2RZOeMS', // Uptown Funk
        'artist': '3hv9jJF3adDNsBSIQDqcjp', // Mark Ronson
      },
      {
        'title': '0GjEhVFGZW8afUYGChu3Rr', // Dancing Queen
        'artist': '0LcJLqbBmaGUft1e9Mm8HV', // ABBA
      },
      {
        'title': '0VjIjW4GlUZAMYd2vXMi3b', // Blinding Lights
        'artist': '1Xyo4u8uXC1ZmMpatF05PJ', // The Weeknd
      },
    ],
  },
  {
    'genre': 'Electro',
    'artistPictureUrl':
        'https://i.scdn.co/image/ab6761610000f17875348e1aade2645ad9c58829',
    'tracks': [
      {
        'title': '1TWfkGrhF7ob0nwB2M6knb', // Animals
        'artist': '60d24wfXkVzDSfLS6hyCjZ', // Martin Garrix
      },
      {
        'title': '2XU0oxnq2qxCpomAAuJY8K', // Dance Monkey
        'artist': '2NjfBq1NflQcKSeiDooVjY', // Tones and I
      },
      {
        'title': '0lHAMNU8RGiIObScrsRgmP', // Titanium
        'artist': '1Cs0zKBU1kc0i8ypK3B9ai', // David Guetta
      },
      {
        'title': '33yAEqzKXexYM3WlOYtTfQ', // D.A.N.C.E
        'artist': '1gR0gsQYfi6joyO1dlp76N', // Justice
      },
      {
        'title': '5UqCQaDshqbIk3pkhy4Pjg', // Levels - Radio Edit
        'artist': '1vCWHaC5f2uS3yhpwWbIA6', // Avicii
      },
      {
        'title': '1x5MjCffpcdHLf65eR9r3T', // Down The Road
        'artist': '28INUgyzTTRbvSphrJbgZ2', // C2C
      },
      {
        'title': '1x5MjCffpcdHLf65eR9r3T', // Down The Road
        'artist': '28INUgyzTTRbvSphrJbgZ2', // C2C
      },
      {
        'title': '1A8j067qyiNwQnZT0bzUpZ', // This Girl
        'artist': '7keGfmQR4X5w0two1xKZ7d', // Kungs
      },
      {
        'title': '3q9oTSo64CrjOiPwI4DbWE', // Baianá
        'artist': '3MyFDtqB80WZvbtCZRsekM', // Bakermat
      },
      {
        'title': '7FOQQJNvfC7x8yO6DQBSFO', // Ani Kuni - Edit
        'artist': '45yEuthJ9yq1rNXAOpBnqM', // Polo & Pan
      },
    ],
  },
  {
    'genre': 'Rock',
    'artistPictureUrl':
        'https://i.scdn.co/image/ab6761610000f17831f6ab67e6025de876475814',
    'tracks': [
      {
        'title': '2aoo2jlRnM3A0NyLQqMN2f', // All Along the Watchtower
        'artist': '776Uo845nYHJpNaStv1Ds4', // Jimi Hendrix
      },
      {
        'title': '2RlgNHKcydI9sayD2Df2xp', // Mr Blue Sky
        'artist': '7jefIIksOi1EazgRTfW2Pk', // Electric Light Orchestra
      },
      {
        'title': '40riOy7x9W7GXjyGp4pjAv', // Hotel California
        'artist': '0ECwFtbIWEVNwjlrfc6xoL', // Eagles
      },
      {
        'title': '39shmbIHICJ2Wxnk1fPSdz', // Should I stay or should I go
        'artist': '3RGLhK1IP9jnYFH4BRFJBS', // The Clash
      },
      {
        'title': '5CQ30WqJwcep0pYcV4AMNc', // Stairway to Heaven
        'artist': '36QJpDe2go2KgaRleHCDTp', // Led Zeppelin
      },
      {
        'title': '7snQQk1zcKl8gZ92AnueZW', // Sweet Child O' Mine
        'artist': '3qm84nBOXUEQ2vnTfUTTFC', // Guns N' Roses
      },
      {
        'title': '54flyrjcdnQdco7300avMJ', // We Will Rock You
        'artist': '1dfeR4HaWDbWqFHLkxsg1d', // Queen
      },
      {
        'title': '2zYzyRzz6pRmhPzyfMEC8s', // Highway to Hell
        'artist': '711MCceyCBcFnzjGY4Q7Un', // AC/DC
      },
    ],
  },
  {
    'genre': 'Rap',
    'artistPictureUrl':
        'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b',
    'tracks': [
      {
        'title': '45KqDHTOJtIM53QR1gPGTa', // Brothers
        'artist': '6pdcQa7by8IKuoVXvgknlI', // Riles
      },
      {
        'title': '4WB9OeauHXnGOMUK4s80gM', // Trop beau
        'artist': '1Yfe3ONJlioHys7jwHdfVm', // Lomepal
      },
      {
        'title': '7lhuM9WUqdThw72dCBRmQW', // Reves bizarres
        'artist': '4FpJcNgOvIpSBeJgRg3OfN', // Orelsan
      },
      {
        'title': '2amrInRmNzmt4Etb6Yn1er', // Cote Ouest
        'artist': '0aXaZj4wB5jLF2E2d8WEVi', // 47ter
      },
      {
        'title': '6DCZcSspjsKoFjzjrWoCdn', // God's Plan
        'artist': '3TVXtAsR1Inumwj472S9r4', // Drake
      },
      {
        'title': '3yfqSUWxFvZELEM4PmlwIR', // The Real Slim Shady
        'artist': '7dGJo4pcD2V6oG8kP0tJRR', // Eminem
      },
      {
        'title': '57I5KhEpQFC9XBgKt6nklL', // On verra
        'artist': '4LXBc13z5EWsc5N32bLxfH', // Nekfeu
      },
    ],
  },
  {
    'genre': 'Metal',
    'artistPictureUrl':
        'https://i.scdn.co/image/ab6761610000f1788101d13bdd630b0889acd2fd',
    'tracks': [
      {
        'title': '0snQkGI5qnAmohLE7jTsTn', // Toxicity
        'artist': '5eAWCfyUhZtHHtBdNk56l1', // System of a down
      },
      {
        'title': '57bgtoPSgt236HzfBOd8kj', // Thunderstruck
        'artist': '711MCceyCBcFnzjGY4Q7Un', // AC/DC
      },
      {
        'title': '5BIMPccDwShpXq784RJlJp', // Enter Sandman
        'artist': '2ye2Wgw4gimLv2eAKyk1NB', // Metallica
      },
      {
        'title': '61mWefnWQOLf90gepjOCb3', // Duality
        'artist': '05fG473iIaoy82BF1aGhL8', // Slipknot
      },
      {
        'title': '0sxYYT48UPkmrDx8p4Hnrl', // Run to the Hills
        'artist': '6mdiAmATAx73kdxrNrnlao', // Iron Maiden
      },
      {
        'title': '2RaA6kIcvomt77qlIgGhCT', // Breaking the Law
        'artist': '2tRsMl4eGxwoNabM08Dm4I', // Judas Priest
      },
      {
        'title': '7ACxUo21jtTHzy7ZEV56vU', // Crazy Train
        'artist': '6ZLTlhejhndI4Rh53vYhrY', // Ozzy Osbourne
      },
    ],
  },
  {
    'genre': 'Raggae',
    'artistPictureUrl':
        'https://i.scdn.co/image/aa79350754a8e9ef651229e7cc5a6d127940c8df',
    'tracks': [
      {
        'title': '0bu5oNxU5pdQuFGxT4gwNr', // Chase the devil
        'artist': '1TsG4AumsMt1Tcq2nHpov9', // Lee Scratch Perry
      },
      {
        'title': '2OHQhOiGIYaXqqJVIMpNrF', // Kingston Town
        'artist': '78u1jLVBjPSXQVmHBV43yG', // Alborosie
      },
      {
        'title': '73lYI49LhfsscO33ohrGN0', // Legalize It
        'artist': '0oea1hwGMfUxZbLxJc1XUN', // Peter Tosh
      },
      {
        'title': '0mD19MC6H0OzHvEUADHypU', // Police in Helicopter
        'artist': '312pFk2xpEwYWLGPehc4Nu', // John Holt
      },
      {
        'title': '7vggqxNKwd6xdRoYS0pQtM', // Three Little Birds
        'artist': '2QsynagSdAqZj3U9HgDzjD', // Bob Marley & The Wailers
      },
      {
        'title': '4uOKFydzAejjSFqYbv1XPt', // Red Red Wine
        'artist': '69MEO1AADKg1IZrq2XLzo5', // UB40
      },
      {
        'title': '7JXVnZsBrFLRwVk9ZqRciI', // Here I Am
        'artist': '2vaWvC8suCFkRXejDOK7EE', // SOJA
      },
      {
        'title': '61iRFcNPdE7dg2RmdhrdZe', // Calypso Queen
        'artist': '56QlZ0AFfkaaHyANLVkg5h', // Calypso Rose
      },
    ],
  },
];

// TODO: Write more end phrases
const List<Map<String, dynamic>> gameOverPhrases = [
  {
    'nbStars': 0,
    'phrases': [
      'You got it wrong',
      'Try again',
      'Feel the tempo',
    ],
  },
  {
    'nbStars': 1,
    'phrases': [
      'Could be better',
      'You can improve',
      'You can do better',
      'Try again !',
    ],
  },
  {
    'nbStars': 2,
    'phrases': [
      'You got it',
      'Well done',
      'Nice',
      "You're almost there !",
    ],
  },
  {
    'nbStars': 3,
    'phrases': [
      "You're wesome!",
      'Perfect !',
      'Awesome !',
      'Amazing !',
    ],
  },
];
