# EXAMPLE ZIG

içi c'est sont des exemples que gemini m'a donnée sur l'utilisation de certains concepts que je trouve nouveau dans zig

# 1 THREAD
Voici un exemple concret d'utilisation de threadlocal en Zig.

Imaginez un serveur ou un système de calcul où plusieurs threads traitent des tâches en parallèle. Chaque thread doit tenir son propre compteur de requêtes traitées et enregistrer un identifiant unique (un ID de session), sans bloquer les autres threads avec des verrous (mutex).

## 1. Le code d'exemple
```zig
const std = @import("std");

// Variable globale classique : PARTAGÉE par tous les threads
var compteur_global_total: std.atomic.Value(u32) = std.atomic.Value(u32).init(0);

// Variable THREADLOCAL : CHAQUE thread aura sa propre copie isolée
threadlocal var requetes_du_thread: u32 = 0;
threadlocal var thread_id_affiche: u32 = 0;

fn traiterTaches(id: u32) void {
    // On initialise les variables threadlocal pour le thread courant
    thread_id_affiche = id;
    requetes_du_thread = 0;

    // Simulation d'une boucle de travail (ex: 3 requêtes)
    var i: u32 = 0;
    while (i < 3) : (i += 1) {
        // Incrémente la variable isolée propre au thread (pas besoin de verrou !)
        requetes_du_thread += 1;

        // Incrémente le compteur global atomique pour le total général
        _ = compteur_global_total.fetchAdd(1, .monotonic);

        // Petite pause pour simuler du travail
        std.time.sleep(10 * std.time.ns_per_ms);
    }

    // Affichage des statistiques propres au thread
    std.debug.print(
        "[Thread {d}] Terminé ! Requêtes gérées par ce thread: {d}\n",
        .{ thread_id_affiche, requetes_du_thread },
    );
}

pub fn main() !void {
    std.debug.print("--- Début des traitements ---\n\n", .{});

    // Création de 3 threads distincts
    var thread1 = try std.Thread.spawn(.{}, traiterTaches, .{1});
    var thread2 = try std.Thread.spawn(.{}, traiterTaches, .{2});
    var thread3 = try std.Thread.spawn(.{}, traiterTaches, .{3});

    // Attente de la fin des threads
    thread1.join();
    thread2.join();
    thread3.join();

    std.debug.print("\n[Global] Total de requêtes traitées sur tous les threads: {d}\n", .{
        compteur_global_total.load(.monotonic),
    });
}
```
## 2. Quel est le résultat dans le terminal ?
À l'exécution, vous obtiendrez un résultat similaire à ceci :

```bash
--- Début des traitements ---

[Thread 1] Terminé ! Requêtes gérées par ce thread: 3
[Thread 3] Terminé ! Requêtes gérées par ce thread: 3
[Thread 2] Terminé ! Requêtes gérées par ce thread: 3

[Global] Total de requêtes traitées sur tous les threads: 9
```
## 3. Ce qu'il faut observer ici
Isolation parfaite : Bien que les 3 threads appellent la même fonction traiterTaches, la modification de requetes_du_thread += 1 ne crée aucune collision entre eux. Le Thread 1, le Thread 2 et le Thread 3 ont chacun leur propre compteur qui monte à 3.

Aucun **Mutex**  requis : Si requetes_du_thread avait été une variable globale classique var, les threads auraient écrasé les données les uns des autres (Data Race) ou il aurait fallu utiliser un std.Thread.Mutex pour sécuriser l'accès, ce qui ralentit les performances.

Pointeurs et adresses : Si vous affichiez l'adresse mémoire de &requetes_du_thread depuis chaque thread (std.debug.print("{*}\n", .{&requetes_du_thread})), vous verriez trois adresses mémoire complètement différentes !

**Quand utiliser threadlocal ?**
Génération de nombres aléatoires : Avoir un générateur PRNG par thread pour éviter de verrouiller le générateur central.

Buffers de travail temporaires : Réutiliser un std.ArrayList ou un buffer d'octets par thread au lieu d'en allouer un nouveau à chaque requête.

Contexte/Traçage : Stocker des identifiants de transaction ou des métriques spécifiques à une tâche en cours d'exécution sur ce thread précis.