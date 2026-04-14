= IEEE 754: Infinito y NaN en doubles

== Representacion en 64 bits

Un `double` tiene 3 campos: 1 bit de signo, 11 de exponente, 52 de mantisa.

#table(
  columns: (auto, auto, auto, auto),
  [*Valor*], [*Signo*], [*Exponente*], [*Mantisa*],
  [Normal], [0/1], [`!= 0x7FF`], [cualquiera],
  [`+Infinity`], [0], [`0x7FF`], [0],
  [`-Infinity`], [1], [`0x7FF`], [0],
  [`NaN`], [0/1], [`0x7FF`], [`!= 0`],
)

Infinito y NaN comparten el exponente maximo (`0x7FF`). La diferencia es la mantisa: cero para infinito, cualquier otra cosa para NaN.

== Como se generan

```cpp
1.0 / 0.0          // +Inf
-1.0 / 0.0         // -Inf
0.0 / 0.0          // NaN
sqrt(-1.0)          // NaN
log(-1.0)           // NaN
INFINITY - INFINITY // NaN
INFINITY * 0.0      // NaN
```

== Propagacion silenciosa

NaN es contagioso: cualquier operacion aritmetica con NaN produce NaN.

```cpp
NaN + 5.0           = NaN
NaN * 0.0           = NaN
clamp(NaN, 0, 100)  = NaN   // std::clamp no lo atrapa
```

No hay excepcion, no hay crash. El valor se propaga silenciosamente hasta que afecta algo visible (un actuador, una pantalla, un log).

== Comparaciones: la trampa

IEEE 754 define que *toda comparacion con NaN es `false`*, incluyendo NaN consigo mismo:

#table(
  columns: (auto, auto, auto),
  [*Expresion*], [*Resultado*], [*Nota*],
  [`NaN == NaN`], [`false`], [],
  [`NaN != NaN`], [`true`], [la unica que da `true`],
  [`NaN < 0.0`], [`false`], [],
  [`NaN > 0.0`], [`false`], [],
  [`NaN <= 0.0`], [`false`], [],
  [`NaN >= 0.0`], [`false`], [],
)

Esto rompe guardas escritas como early-return negativo:

```cpp
// PELIGROSO: NaN pasa esta guarda
if (dt <= 0.0) return;  // NaN <= 0.0 es false, no retorna

// SEGURO: NaN no pasa
if (!(dt > 0.0)) return;  // !(false) = true, retorna

// EXPLICITO: la forma mas clara
if (!std::isfinite(dt) || dt <= 0.0) return;
```

== Funciones de deteccion (`<cmath>`)

#table(
  columns: (auto, auto),
  [*Funcion*], [*Retorna `true` cuando*],
  [`std::isnan(x)`], [solo para NaN],
  [`std::isinf(x)`], [solo para `+/-Inf`],
  [`std::isfinite(x)`], [solo para valores normales (ni NaN ni Inf)],
)

== Por que importa en sistemas embebidos

En un controlador PID, un NaN en el acumulador integral es permanente: una vez contaminado, *todos los ticks futuros producen NaN* porque `NaN += ki * error * dt` sigue siendo NaN. El actuador recibe comandos basura indefinidamente sin que el sistema lance ninguna excepcion.

Por eso en `pid.h` se usa `is_valid_dt()`:

```cpp
static inline bool is_valid_dt(double dt) {
    return std::isfinite(dt) && dt > 0.0;
}
```

Rechaza NaN, Inf, cero y negativos en un solo lugar, evitando la contaminacion del estado interno del PID.
