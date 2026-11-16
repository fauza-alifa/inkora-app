# INKORA — Digital News Application

**Inkora is a modern digital news application that delivers the latest updates across various categories, including business, technology, science, and health. With a clean and intuitive interface, Inkora makes it easy for users to explore, read, and save news articles in one convenient platform.**

## Features

INKORA provides a range of features designed to create a convenient and enjoyable news-reading experience:

- **Latest News**
- **News Categories**
- **Search Articles**
- **Article Details**
- **Bookmark Articles**
- **Bookmark Counter**
- **News Archive**
- **Date-Based News Filtering**
- **Dark & Light Mode**

## Tech Stack

- **Framework:** Flutter
- **Programming Language:** Dart
- **State Management:** Riverpod
- **API:** NewsAPI
- **Networking:** HTTP
- **Local Storage:** SharedPreferences
- **Date Formatting:** Intl

## Project Structure

The project follows a structured organization to separate application logic, data handling, and user interface components.

lib/
├── core/
│   ├── constants/
│   ├── router/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── providers/
└── ui/
    ├── screens/
    └── widgets/

## API

INKORA uses [NewsAPI](https://newsapi.org/) to retrieve news articles and headlines from various sources.