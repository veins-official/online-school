# 🎓 Online School Platform

Платформа для онлайн-школы на **Flutter + PocketBase + LiveKit**.
Учителя создают ДЗ и встречи, ученики их сдают и подключаются к видеозвонкам,
все конференции записываются.

---

## 🧭 Как пользоваться этим README

Это пошаговый roadmap. Каждая задача — атомарная: закрывается одним
промтом к ИИ и небольшой проверкой. Промты уже написаны — копируй их
как есть, подставляя свои файлы, где указано.

Правила:

1. Идти строго по порядку. Каждый следующий этап опирается на предыдущий.
2. Если что-то не работает — вернуться на шаг назад, не «лечить» наперёд.
3. Если генерируемый код отклоняется от нашей архитектуры, использовать
   раздел **«Шаблоны промтов»** ниже — там жёстко зафиксированы слои и зависимости.
4. После каждого этапа ставить галочку `[x]`.

---

## 🛠️ Подготовка окружения

- [ ] Установлен **Flutter SDK** (`flutter --version`)
- [ ] Установлен **Android Studio** или **VS Code** с плагином Flutter
- [ ] Скачан **PocketBase** (https://pocketbase.io/docs/, один бинарник)
- [ ] Установлен **Docker** (для LiveKit на этапе 6)
- [ ] Настроен аккаунт GitHub (для бэкапов и CI)

---

## 🗺️ ROADMAP

Легенда: 🟢 просто · 🟡 средне · 🔴 сложно

---

### 🟩 Этап 1. PocketBase — коллекции и правила доступа

**Цель:** поднять сервер и создать все коллекции.

- [ ] **1.1** 🟢 Запустить PocketBase

  ```bash
  ./pocketbase serve
  ```
  Открыть http://127.0.0.1:8090/_/, создать админа, запомнить креды.

- [ ] **1.2** 🟢 Расширить коллекцию `users`

  В админке → Collections → users → добавить поля:

  | Имя | Тип | Настройки |
  |---|---|---|
  | `name` | text | — |
  | `role` | select | `student`, `teacher`, `admin` |
  | `avatar` | file | single, max 5MB |
  | `bio` | text | — |

  **API Rules → Update:** `id = @request.auth.id || @request.auth.role = "admin"`

- [ ] **1.3** 🟡 Коллекция `teacher_student`

  | Имя | Тип | Настройки |
  |---|---|---|
  | `teacher` | relation | users, filter: `role="teacher"` |
  | `student` | relation | users, filter: `role="student"` |
  | `subject` | text | — |

- [ ] **1.4** 🟡 Коллекция `assignments`

  | Имя | Тип | Настройки |
  |---|---|---|
  | `title` | text | required |
  | `description` | editor | — |
  | `teacher` | relation | users |
  | `student` | relation | users |
  | `subject` | text | — |
  | `due_date` | date | — |
  | `attachments` | file | multiple, max 20MB |
  | `status` | select | `active`, `closed` |

  **API Rules:**
  - Create: `@request.auth.role = "teacher" && teacher = @request.auth.id`
  - View: `teacher = @request.auth.id || student = @request.auth.id`

- [ ] **1.5** 🟡 Коллекция `submissions`

  Поля: `assignment` (relation → assignments), `student` (relation → users),
  `text` (text), `files` (file, multiple), `grade` (number), `feedback` (text),
  `status` (select: `submitted`, `graded`, `returned`).

- [ ] **1.6** 🟡 Коллекция `meetings`

  Поля: `title`, `teacher` (relation), `participants` (relation users, multiple),
  `room_name` (text, unique), `start_at` (date), `duration_min` (number),
  `status` (select: `scheduled`, `live`, `ended`), `recording_url` (url).

- [ ] **1.7** 🟢 Коллекция `notifications`

  Поля: `user` (relation users), `type` (select), `payload` (json), `read` (bool).

✅ **Чекпоинт:** в админке PocketBase видны все 6 коллекций с корректными правилами.

---

### 🟩 Этап 2. Аутентификация и роли

**Цель:** регистрация, вход, приложение знает роль пользователя.

- [ ] **2.1** 🟡 `AuthRepository`

  **Файл:** `lib/features/auth/data/auth_repository.dart`

  **Промт:**
  > Создай класс AuthRepository в lib/features/auth/data/auth_repository.dart.
  > Singleton через приватный конструктор `AuthRepository._internal()` и
  > статическое поле `instance`. Приватное поле `_pb = PocketBaseClient.instance`.
  > Публичные методы:
  > - `Future<void> login(String email, String password)`
  > - `Future<void> register({required String email, required String password,
  >   required String name, required String role})`
  > - `Future<void> logout()`
  > - `Future<void> restoreSession()`
  > - `bool get isAuthenticated`
  > - `String? get currentUserId`
  > - `String? get currentUserRole`
  > Использовать `_pb.client.collection('users').authWithPassword(...)` и
  > `_pb.client.authStore`. Токен сохранять в `SecureStorage.instance`.

- [ ] **2.2** 🟡 `auth_provider.dart`

  **Файл:** `lib/features/auth/presentation/providers/auth_provider.dart`

  **Промт:**
  > Создай Riverpod-провайдеры для auth:
  > - `authRepositoryProvider` → `AuthRepository.instance`
  > - `authStateProvider` — `StateNotifierProvider<AuthNotifier, AuthState>`,
  >   где `AuthState` — класс с полями `user`, `role`, `isLoading`, `error`.
  > Методы notifier: `login`, `register`, `logout`, `restoreSession`.
  > Использовать AuthRepository. Не обращаться к PocketBase напрямую.

- [ ] **2.3** 🟢 `LoginScreen`

  **Файл:** `lib/features/auth/presentation/screens/login_screen.dart`

  **Промт:**
  > Реализуй LoginScreen (ConsumerWidget). Форма: email, password
  > (через AppTextField), кнопка «Войти» (AppButton с isLoading из authStateProvider).
  > Валидация через `Validators.email` и `Validators.password`. При успехе —
  > `context.go(Routes.home)`. Ссылка «Регистрация» → `context.go(Routes.register)`.
  > Ошибки показывать через `context.showSnack`.

- [ ] **2.4** 🟢 `RegisterScreen`

  **Промт:**
  > Аналогично LoginScreen, но поля: name, email, password, а также
  > `DropdownButton` для выбора роли (student / teacher). При успехе —
  > `context.go(Routes.home)`.

- [ ] **2.5** 🟡 Guard в `AppRouter`

  **Файл:** `lib/core/router/app_router.dart`

  **Промт:**
  > В AppRouter добавь `redirect`: если пользователь не авторизован и идёт
  > не на `/login` или `/register` — отправлять на `/login`. Если авторизован
  > и идёт на `/login` — отправлять на `/`. Использовать `refreshListenable`
  > поверх authStateProvider. Также добавь redirect по ролям: на `/students`
  > пускать только `teacher` и `admin`. Сохрани текущую структуру роутера.

✅ **Чекпоинт:** регистрация и вход работают, роутер корректно редиректит.

---

### 🟩 Этап 3. Профиль и связи учитель ↔ ученик

**Цель:** учитель видит своих учеников, ученик — своих учителей.

- [ ] **3.1** 🟡 Модель `TeacherStudent`

  **Файл:** `lib/features/students/data/models/teacher_student.dart`

  **Промт:**
  > Создай модель `TeacherStudent extends BaseModel` с полями:
  > `id`, `teacherId`, `studentId`, `subject`. `fromJson` обрабатывает
  > snake_case (`teacher`, `student`), `toJson` не включает `id` при создании.
  > Все поля `final`.

- [ ] **3.2** 🟡 `StudentsRepository`

  **Файл:** `lib/features/students/data/students_repository.dart`

  **Промт:**
  > Singleton `StudentsRepository`. Методы:
  > - `Future<List<UserModel>> fetchTeacherStudents(String teacherId)`
  > - `Future<List<UserModel>> fetchStudentTeachers(String studentId)`
  > - `Future<void> assignTeacher({required String teacherId,
  >   required String studentId, required String subject})`
  > - `Future<void> unassign(String relationId)`
  > Работать через `_pb.teacherStudent` и `_pb.users`. Возвращать доменные
  > модели, а не RecordModel. Если модели `UserModel` ещё нет — создать её
  > в `lib/features/auth/data/models/user_model.dart` (поля: id, email, name,
  > role, avatarUrl, bio).

- [ ] **3.3** 🟡 `students_provider.dart`

  **Промт:**
  > Создай Riverpod-провайдеры:
  > - `studentsRepositoryProvider`
  > - `myStudentsProvider` (FutureProvider) — для текущего учителя
  > - `myTeachersProvider` (FutureProvider) — для текущего ученика
  > Использовать `currentUserId` из `authStateProvider` (через `watch`).

- [ ] **3.4** 🟢 `StudentsListScreen`

  **Промт:**
  > Замени заглушку StudentsListScreen. Список учеников учителя
  > (`myStudentsProvider`) через ListView. Элемент — ListTile с UserAvatar,
  > именем и предметом. Пусто — EmptyState, загрузка — LoadingIndicator.
  > В AppBar кнопка «+» → `context.push('/students/assign')`.

- [ ] **3.5** 🟢 `AssignTeacherScreen`

  **Промт:**
  > Замени заглушку AssignTeacherScreen. Форма: dropdown учеников
  > (users с `role="student"`), dropdown учителей (`role="teacher"`),
  > поле subject. Кнопка «Назначить» вызывает `assignTeacher` и после
  > успеха делает `context.pop()`.

✅ **Чекпоинт:** учитель видит своих учеников, пары назначаются.

---

### 🟩 Этап 4. Домашние задания

**Цель:** учитель создаёт ДЗ, ученик сдаёт, учитель ставит оценку.

- [ ] **4.1** 🟡 Доработать модели `Assignment` и `Submission`

  **Промт:**
  > Проверь модели Assignment и Submission в
  > `lib/features/assignments/data/models/`. Убедись, что `fromJson`:
  > - мапит snake_case → camelCase
  > - `attachments` / `files` → `List<String>` публичных URL (через
  >   `PocketBaseClient.client.files.getUrl`)
  > - `due_date` → `DateTime`
  > `toJson` не включает `id` при создании.

- [ ] **4.2** 🟡 `AssignmentsRepository`

  **Промт:**
  > В `lib/features/assignments/data/assignments_repository.dart` реализуй:
  > - `Future<List<Assignment>> fetchForStudent(String studentId)`
  > - `Future<List<Assignment>> fetchForTeacher(String teacherId)`
  > - `Future<Assignment> createAssignment({required String title,
  >   required String description, required String teacherId,
  >   required String studentId, required String subject,
  >   required DateTime dueDate, List<File> attachments})`
  > - `Future<void> closeAssignment(String id)`
  > Использовать `_pb.assignments`. Файлы грузить через `MultipartFile`.
  > Внутренний mapper `RecordModel → Assignment`.

- [ ] **4.3** 🟡 `SubmissionsRepository`

  **Промт:**
  > Аналогично, для submissions:
  > - `fetchForAssignment(String assignmentId)`
  > - `fetchForStudent(String studentId)`
  > - `submit({required String assignmentId, required String studentId,
  >   required String text, List<File> files})`
  > - `grade({required String submissionId, required int grade,
  >   required String feedback})`

- [ ] **4.4** 🟡 Провайдеры для assignments

  **Промт:**
  > Riverpod-провайдеры:
  > - `assignmentsRepositoryProvider`
  > - `myAssignmentsProvider` — зависит от роли: учитель → `fetchForTeacher`,
  >   ученик → `fetchForStudent`
  > - `assignmentByIdProvider` — `family<String, Assignment?>`
  > - `submissionsForAssignmentProvider` — `family<String, List<Submission>>`

- [ ] **4.5** 🟢 `AssignmentsListScreen`

  **Промт:**
  > Список ДЗ (`myAssignmentsProvider`) через ListView. Карточка: title,
  > subject, `due_date` (через `DateFormatter.date`), статус. Тап →
  > `context.push('/assignments/$id')`. Для учителя — FAB → `/assignments/create`.
  > Realtime: подписаться на `_pb.assignments.subscribe('*', ...)` и
  > инвалидировать провайдер.

- [ ] **4.6** 🟢 `CreateAssignmentScreen`

  **Промт:**
  > Форма: title, description, dropdown учеников (из teacher_student),
  > subject, DatePicker для due_date, FilePicker (до 5 файлов). Кнопка
  > «Создать» → `createAssignment`. После успеха `context.pop()` +
  > `ref.invalidate(myAssignmentsProvider)`.

- [ ] **4.7** 🟢 `AssignmentDetailScreen`

  **Промт:**
  > Экран с TabBar:
  > - «Задание»: описание, вложения (открытие через `url_launcher`), due_date.
  > - «Решение»: для ученика — форма отправки, для учителя — список submissions
  >   с оценками и кнопкой «Оценить».

- [ ] **4.8** 🟢 `SubmissionScreen`

  **Промт:**
  > Форма: многострочный text + FilePicker (до 5 файлов). Если уже сдано —
  > показать статус и оценку. Кнопка «Отправить» → `submit()`. После успеха
  > `context.pop()` + `ref.invalidate(submissionsForAssignmentProvider)`.

✅ **Чекпоинт:** полный цикл ДЗ работает end-to-end.

---

### 🟩 Этап 5. Realtime и уведомления

**Цель:** новые ДЗ и оценки появляются без перезагрузки.

- [ ] **5.1** 🟡 `RealtimeService`

  **Файл:** `lib/core/network/realtime_service.dart`

  **Промт:**
  > Создай `RealtimeService` (singleton). Метод `start()` подписывается на
  > `_pb.assignments`, `_pb.submissions`, `_pb.meetings`, `_pb.notifications`.
  > Принимает callbacks `onCreate`, `onUpdate`, `onDelete`. Метод `stop()`
  > отписывается. Подписки хранить в приватном поле `_subscriptions`.

- [ ] **5.2** 🟡 Репозиторий уведомлений

  **Промт:**
  > Создай `NotificationsRepository` + `notificationsProvider`.
  > `fetchUnread()` возвращает `List<Notification>` для `currentUserId`.
  > При realtime-событии `onCreate` — `ref.invalidate`.

- [ ] **5.3** 🟡 PocketBase hook — уведомление при создании ДЗ

  **Файл:** `pb_hooks/main.pb.js`

  **Промт:**
  > Напиши PocketBase JS hook: при создании записи в `assignments` создавать
  > запись в `notifications` с `user=student`, `type='assignment'`,
  > `payload={assignmentId, title}`. Использовать `onRecordAfterCreateRequest`.

- [ ] **5.4** 🟢 Иконка уведомлений

  **Промт:**
  > В AppBar главного экрана добавь иконку bell с badge (количество
  > непрочитанных из `notificationsProvider`). Тап → BottomSheet со списком.
  > При тапе на уведомление — `read=true` и переход по маршруту
  > (`assignment` → `/assignments/$id`).

✅ **Чекпоинт:** новое ДЗ появляется у ученика без перезагрузки.

---

### 🟩 Этап 6. Видеосвязь (LiveKit)

**Цель:** учитель и ученик созваниваются прямо в приложении.

- [ ] **6.1** 🔴 Поднять LiveKit сервер

  ```bash
  docker run --rm -p 7880:7880 -p 7881:7881 -p 7882:7882/udp \
    -e LIVEKIT_KEYS="devkey: secret" \
    livekit/livekit-server --dev
  ```

  **Промт (проверка):**
  > Объясни пошагово, как поднять LiveKit локально в Docker и как проверить,
  > что сервер работает. Что такое `LIVEKIT_KEYS`, ws URL, и как это связано
  > с `flutter livekit_client`.

- [ ] **6.2** 🔴 Генерация токенов LiveKit

  **Файл:** `pb_hooks/livekit.pb.js`

  **Промт:**
  > Напиши PocketBase hook — роут `POST /api/livekit/token`. Принимает
  > `{ roomName, identity }`, возвращает JWT-токен для LiveKit. Использовать
  > `livekit-server-sdk`. Если невозможно в pb_hooks — предложи отдельный
  > маленький Node/Python сервис и опиши его.

- [ ] **6.3** 🟡 `MeetingsRepository`

  **Промт:**
  > Реализуй `MeetingsRepository`: `fetchUpcoming()`, `create()`,
  > `startMeeting()` (status='live'), `endMeeting()` (status='ended'),
  > `getLiveKitToken(roomName)` — дергает `/api/livekit/token`.

- [ ] **6.4** 🟢 `MeetingsListScreen`

  **Промт:**
  > Список встреч. Для учителя — FAB «Создать» → `/meetings/create`.
  > Карточка: title, start_at, статус. Тап → `/meetings/$id/call`.

- [ ] **6.5** 🟢 `CreateMeetingScreen`

  **Промт:**
  > Форма: title, DatePicker+TimePicker для start_at, duration_min,
  > мультивыбор участников. Кнопка «Создать» → `meetingsRepository.create()`.
  > `room_name` генерировать как `room_${uuid}`.

- [ ] **6.6** 🔴 `VideoCallScreen` — ядро

  **Промт:**
  > Реализуй `VideoCallScreen` (ConsumerStatefulWidget) с livekit_client.
  > 1. В `initState`: получить токен через `getLiveKitToken`, подключиться:
  >    `Room()`, `room.connect(Env.liveKitUrl, token)`.
  > 2. Включить камеру и микрофон: `room.localParticipant.setCameraEnabled(true)`,
  >    `setMicrophoneEnabled(true)`.
  > 3. Слушать `room.events` — обновлять UI при появлении/уходе участников.
  > 4. UI: GridView из `VideoTrackRenderer` для каждого участника.
  > 5. В AppBar: mute, camera toggle, «Запись» (только учителю), «Выйти».
  > 6. В `dispose`: `room.disconnect()`.
  > Room хранить в приватном поле `_room`, слушатели — в `_listeners`.

✅ **Чекпоинт:** два устройства видят друг друга в видеозвонке.

---

### 🟩 Этап 7. Запись встреч

**Цель:** после звонка появляется ссылка на запись.

- [ ] **7.1** 🔴 Настроить LiveKit Egress

  **Промт:**
  > Объясни, как настроить LiveKit Egress для записи комнаты в файл на S3
  > или локально. Как запустить egress-контейнер. Как из Flutter дернуть
  > Egress API (через наш бэкенд).

- [ ] **7.2** 🔴 Кнопка «Запись» в `VideoCallScreen`

  **Промт:**
  > Добавь в VideoCallScreen кнопку «Начать запись» (только учителю).
  > При нажатии — `POST /api/livekit/start-recording` с `roomName`.
  > Бэкенд вызывает Egress API. При выходе учителя — автоматически
  > останавливать запись.

- [ ] **7.3** 🟡 PocketBase webhook от Egress

  **Файл:** `pb_hooks/livekit.pb.js`

  **Промт:**
  > Добавь роут `POST /api/livekit/webhook`. Принимает `{ room, url }`.
  > Находит meeting по `room_name`, ставит `recording_url=url`,
  > `status='ended'`.

- [ ] **7.4** 🟢 `RecordingsListScreen`

  **Промт:**
  > Список записей — meetings с непустым `recording_url`, доступные
  > пользователю. Карточка: title, дата, длительность. Тап →
  > `RecordingPlayerScreen`.

- [ ] **7.5** 🟢 `RecordingPlayerScreen`

  **Промт:**
  > Экран с `VideoPlayer` + `ChewieController`. URL из `recording_url`.
  > Индикатор загрузки, обработка ошибок.

✅ **Чекпоинт:** после звонка появляется запись и воспроизводится.

---

### 🟩 Этап 8. Расписание и полировка

- [ ] **8.1** 🟢 `ScheduleScreen`
- [ ] **8.2** 🟢 Проверить тёмную тему (уже есть в `AppTheme`)
- [ ] **8.3** 🟢 Локализация ru/en (`intl`)
- [ ] **8.4** 🟡 Push-уведомления через FCM
- [ ] **8.5** 🟢 Обработка ошибок и empty states везде
- [ ] **8.6** 🟢 Логотип, splash screen, иконка приложения

---

### 🟩 Этап 9. Деплой

- [ ] **9.1** 🟡 PocketBase на VPS (Docker + Caddy/Nginx + SSL)
- [ ] **9.2** 🟡 LiveKit на VPS
- [ ] **9.3** 🟡 S3-совместимое хранилище для записей (MinIO)
- [ ] **9.4** 🟡 Бэкапы PocketBase (`pb_data` → cron → S3)
- [ ] **9.5** 🟡 Сборка APK / IPA / Web (`flutter build`)
- [ ] **9.6** 🟢 CI/CD через GitHub Actions

---

## 🧩 Шаблоны промтов

### Новый экран
> Создай экран `<Name>` в `lib/features/<feature>/presentation/screens/<name>_screen.dart`.
> ConsumerWidget (или ConsumerStatefulWidget при необходимости lifecycle).
> Использовать AppButton, AppTextField, LoadingIndicator, EmptyState.
> Данные — через `<name>Provider`. Навигация — через `context.go/push`
> с `Routes.*`. Ничего не импортировать из `core/network` напрямую.

### Новый репозиторий
> Создай `<Name>Repository` в `lib/features/<feature>/data/`.
> Singleton: приватный `_internal()` + `static final instance`.
> Приватное поле `_pb = PocketBaseClient.instance`.
> Методы возвращают доменные модели (из `data/models/`), не RecordModel.
> Внутренний mapper `_mapRecord(RecordModel) → Model`.

### Новый провайдер
> Создай Riverpod-провайдеры в
> `lib/features/<feature>/presentation/providers/<name>_provider.dart`:
> - `<name>RepositoryProvider`
> - `<name>ListProvider` — `FutureProvider.autoDispose`
> - `<name>ByIdProvider` — `FutureProvider.family`
> Использовать только репозиторий, не PocketBase.

### Добавить поле в коллекцию PocketBase
> В коллекции `<name>` добавь поле `<field>` типа `<type>`. Обнови:
> - модель в `lib/features/<feature>/data/models/`
> - mapper в `<Feature>Repository`
> - UI в соответствующих экранах
> Не ломать существующие поля.

---

## 🆘 Частые проблемы

| Проблема | Решение |
|---|---|
| `flutter run` не находит устройство | `flutter devices`, затем `flutter run -d chrome` |
| PocketBase 401 | Проверить API Rules в админке, перелогиниться |
| Realtime не приходит | Убедиться, что сервер запущен и subscribe вызван |
| LiveKit не коннектится | Проверить URL (`ws://` не `http://`), токен, доступность egress |
| Файлы не грузятся | Проверить `max file size` в Settings → Files |

---

## ✅ Финальный чеклист MVP

- [ ] Регистрация/логин с ролями
- [ ] Учитель видит своих учеников, ученик — своих учителей
- [ ] Учитель создаёт ДЗ с вложениями
- [ ] Ученик видит ДЗ и сдаёт работу
- [ ] Учитель ставит оценку и фидбек
- [ ] Уведомления о новых ДЗ
- [ ] Видеозвонок учитель ↔ ученик
- [ ] Запись звонка сохраняется и воспроизводится
- [ ] Тёмная тема
- [ ] Собирается в APK и запускается на телефоне

Когда всё отмечено — MVP готов. Дальше: тесты, аналитика, полировка UI.
