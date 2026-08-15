# MediaTrax 🎬🎵

**MediaTrax** es una aplicación multiplataforma diseñada para descargar video y audio mediante URLs de forma rápida e intuitiva. El proyecto cuenta con una versión para **Windows (Desktop)** y una versión para **Android (Mobile)**.

---

## 🛠️ Arquitectura del Proyecto

El repositorio está organizado dentro de la carpeta `src/` de la siguiente forma:

```text
Media-Trax/
├── src/
│   ├── desktope code version/
│   │   ├── api/       # API Backend en Python (FastAPI / PyInstaller)
│   │   └── client/    # Cliente de escritorio (Flutter)
│   └── mobile code version/
│       └── mediatrax/ # App móvil nativa/multiplataforma (Flutter)
└── README.md
```

- **Versión Desktop:** Combina un backend ligero desarrollado en **Python** que gestiona la extracción/descarga del contenido y una interfaz gráfica moderna e interactiva construida en **Flutter**.
- **Versión Mobile:** Aplicación nativa en **Flutter** optimizada para dispositivos Android.

---

## ✨ Características

- 📹 **Descarga de Video y Audio:** Extrae contenido audiovisual en alta calidad directamente desde enlaces web.
- 💻 **Soporte Windows:** Interfaz cliente-servidor ultrarrápida.
- 📱 **Soporte Android:** Experiencia fluida adaptada a pantallas táctiles.
- 🎨 **Interfaz Moderna:** Diseño limpio e intuitivo desarrollado en Flutter.

---

## 🚀 Requisitos e Instalación

### Prerrequisitos

- **Flutter SDK** (v3.x o superior)
- **Python** (v3.10+ para el entorno de la API de Escritorio)
- **Git**

---

### 🏃‍♂️ Ejecución en Desarrollo

#### 1. Versión Desktop (Escritorio)

**Backend (API Python):**
```bash
cd "src/desktope code version/api"
pip install -r requirements.txt  # Instalar dependencias
python main.py                   # Iniciar servidor local
```

**Cliente (Flutter Desktop):**
```bash
cd "src/desktope code version/client"
flutter pub get
flutter run -d windows
```

#### 2. Versión Mobile (Android)

Conecta tu dispositivo Android o inicia un emulador:

```bash
cd "src/mobile code version/mediatrax"
flutter pub get
flutter run
```

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia **Apache-2.0**.