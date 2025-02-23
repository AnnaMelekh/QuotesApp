# DevRush Pet Project #4
<p align="center">
  <img src="https://github.com/AnnaMelekh/QuotesApp/blob/main/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-02-23%20at%2019.46.51.png" width="150">
  <img src="https://github.com/AnnaMelekh/QuotesApp/blob/main/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-02-23%20at%2019.47.05.png" width="150">
  <img src="https://github.com/AnnaMelekh/QuotesApp/blob/main/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202025-02-23%20at%2019.55.49.png" width="150">
</p>

## Overview  
This project is a simple iOS app that displays a **random quote of the day**, fetched using `URLSession`. Users can refresh the quote or save it to **Bookmarks** for later reference.

## Features  

### 📜 Main Screen  
- Displays a random quote from an API.  
- Users can refresh the quote.  
- Quotes can be saved to **Bookmarks** using `BookmarkManager` (`UserDefaults`).  

### 🔖 Bookmarks Screen  
- Users can search through saved bookmarks using `UISearchBar`.  
- Bookmarks can be deleted using a standard **right swipe** action.  

### 📂 Categories List  
- Users can choose a category (but currently, it does not filter quotes due to API restrictions).  

## Technologies Used  
- Swift  
- UIKit  
- URLSession  
- UserDefaults  

---

