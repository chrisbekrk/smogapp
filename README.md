# SmogApp

Aplikacja prezentująca aktualne pomiary z najbliższych stacji w danym mieście.
Wykorzystuje dane z <http://powietrze.gios.gov.pl/pjp/content/api>  

## Wymagania

Aby zbudować aplikacje wymagany jest kompilator z swift 4 (np. Xcode 9.2)
Nie stosowałem żadnych dodatkowych bibliotek - starałem się pisać wszystko natywnie dlatego nie potrzeba używania CocoaPods czy Carthage.

## Stan prac

Głowne funcje zostały spełnione - aplikacja przedstawia jakość powietrza w zależności od miasta i wybranej stacji.
Projektowaniem UX sugerowałem się aktualnym designem z App Store (duże karty i cień pod nimi).
Dużym blockerem było nie działające API które bardzo często nie odpowiada albo z dużym opóznieniem (mockowałem jsony ale brakuje pełnej dokumentacji)

### DONE

* Szkielet aplikacji
* Stworzenie klas do komunikacji z API
* Pobieranie stacji
* Pobieranie lokalizacji użytkownika
* UX pierwszego widoku - prezentacji danych oraz wyboru stacji w mieście
* Dodana animacja do karty stacji
* Wstępne prace graficzne

### TO DO

* Dokończenie widoku zmiany miast i logiki.
* Testy XCTestCase
* Prace graficzne
* Zmiana klas na realmowskie aby nie pobierac za każdym razem stacji
* Przepisanie widoków do kodu
* Dodanie animacji

### NICE TO HAVE :)

* Ulubione stacje/miasta
* Widget
* Aplikacja na Apple Watch
