# Symulacja Hybrydowa: Dyfuzja Innowacji i Ewolucja Opinii

Projekt zawiera hybrydowy model agentowy (ABM) łączący model ewolucji opinii ciągłych **Hegselmanna-Krausego** z progowym modelem dyfuzji binarnej **Granovettera**, osadzony w topologii sieci złożonej **Small-World (Wattsa-Strogatza)**.

## Wymagania systemowe
* **Środowisko:** NetLogo w wersji 6.x lub 7.x (zalecana wersja 7.0.3 lub nowsza).
* **Rozszerzenia:** Wbudowane rozszerzenie sieciowe `nw` (Network Extension) – instaluje się automatycznie wraz z programem NetLogo.

## Struktura plików w repozytorium
* `/model/model_v1.nlogo` – główny plik kodu i interfejsu symulacji.
* `/results/model_sym wpływ_parametry_v2.csv` – surowe dane z eksperymentów BehaviorSpace.
* `README.md` – instrukcja uruchomienia.
* `/model/model_sym.nlogox` – Główna struktura i kod źródłowy modelu. Wystarczający plik dla całego eksperymentu
* `/model/eksperyment.xml` – Zewnętrzny plik konfiguracyjny BehaviorSpace (zakresy parametrów, liczba powtórzeń).

---

## Instrukcja uruchomienia symulacji (Krok po kroku)

### 1. Uruchomienie pojedynczego przebiegu (Interfejs graficzny)
1. Otwórz program **NetLogo**.
2. Wybierz z menu górnego `File -> Open` i wskaż plik `model_sym.nlogx`.
3. W zakładce **Interface** ustaw parametry startowe za pomocą suwaków:
   * `epsilon`: Promień ufności / tolerancji poznawczej (zalecany zakres: `0.05` - `0.45`).
   * `average-threshold`: Średni próg podatności populacji na nową ideę (zalecany zakres: `0.05` - `0.25`).
4. Kliknij przycisk **`setup`** – licznik `ticks` zresetuje się do zera, sieć Small-World zostanie wygenerowana na okręgu, a 3 innowatorów zaświeci się na czerwono.
5. Kliknij przycisk **`go`** (z ikoną pętli), aby rozpocząć symulację. Symulacja zatrzyma się automatycznie po osiągnięciu stanu stabilnego lub limitu `500` kroków czasowych.

### 2. Uruchomienie eksperymentów masowych (BehaviorSpace)
Jeśli chcesz powtórzyć badania statystyczne i wygenerować plik `.csv` z całą macierzą wyników:
1. Z menu górnego wybierz `Tools -> BehaviorSpace`.
2. Na liście eksperymentów zaznacz pozycję `wpływ_parametry` i kliknij przycisk **Run**.
3. W oknie konfiguracji wyjściowej wybierz opcję **Table output** (lub Spreadsheet) i kliknij **OK**.
4. Wskaż miejsce na dysku, gdzie program ma zapisać plik `.csv` (np. katalog `/results`) i zatwierdź.
5. NetLogo uruchomi proces obliczeniowy w tle (bez odświeżania grafiki), wykonując automatycznie wszystkie zaplanowane powtórzenia symulacji.
---