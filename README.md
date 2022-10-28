# МДиСУБД 2022
## Бураков Дмитрий, гр. 053501
Тема проекта __"Частная сеть ветеринарных клиник"__
___
## Описание предметной области
### Ветеринарная клиника
Частная сеть ветеринарных клиник располагается по всей террирории страны N. Каждая клиника имеет штаб персонала.
Данные клиники: уникальный идентификационный номер, адрес, номер телефона.
### Фармацевтические препараты
Каждая клиника имеет запас фармацевтический препаратов.
Данные: уникальный иденцификационный номер, название, фармакологический указатель, срок годности, дополнительная информация.
### Оборудование
Каждая клиника имеент набор медицинского оборудования.
Данные: уникальный иденцификационный номер, название, дата приобретения, описание.
### Персонал
Данные персонала: уникальный идентификационный номер, ФИО, клиника, должность, паспорт, номер телефона, адрес электронной почты.
### Клиент
Данные клиента: уникальный идентификационный номер, ФИО, паспорт, дата регистрации, адрес электронной почты.
### Паспортные данные 
Паспортные данные: уникальный идентификационный номер, дата рождения, пол, ИИН, адрес прописки.
### Животное
Данные животного: уникальный идентификационный номер, имя, владелец.
### Медицинская карта
Учет заболеваний животных.
Данные медицинской карты: уникальный иденцификационный номер, животное, дата назначения диагноза, диагноз.
### Осмотр 
Медицинский осмотр животного-пациента.
Данные осмотра: уникальный иденцификационный номер, дата и время, врач, животное, результаты осмотра.
### Курс лечения
В результати осмотра животному может требоваться лечение. 
Данные: уникальный иденцификационный номер, осмотр, врач, описание.
### Медицинские услуги
Курс лечения состоит из медицинских услуг и препаратов. 
Данные: уникальный иденцификационный номер, название, стоимость. 
___
## Функциональные требования к проекту
1. Обязательыне требования:
    - Авторизация пользователя.
    - Управление пользователями (CRUD).
    - Система ролей (Admin, Manager, Stuff).
    - Журналирование действий пользователя.
2. Функции создания записей и их изменения:
    - Создание и хранение записей, содержащих информацию о клинках и их сотрудниках (Admin)
    - Создание и хранение записей, содержащих информацию о клиентах (Admin, Manager)
    - Создание и хранение записей, содержащих информацию о животных-пациентах (Admin, Manager)
    - Создание и хранение записей, содержащих информацию об осмотрах (Admin, Manager, Stuff)
    - Создание и хранение записей, содержащих информацию о курсах лечения (Admin, Manager, Stuff)
    - Создание и хранение записей, содержащих информацию о записях медкарты (Admin, Manager, Stuff)
    - Создание и хранение записей, содержащих информацию о медицинских услугах (Admin, Manager) 
    - Создание и хранение записей, содержащих информацию о фармацевтических запасов (Admin, Manager, Stuff)
    - Создание и хранение записей, содержащих информацию об оборудовании (Admin, Manager, Stuff)
3. Должны быть реализованы следующие запросы к базе данных:
    - Предоставить отчет с указанием менеджера, адреса клиники и номера телефона для каждой клиники, упорядоченных по номеру центра.
    - Предоставить отчет, в котором перечислены имена клиентов и информацию о них.
    - Предоставить отчет, в котором перечислены имена животных-пациентов и информацию о них.
    - Предоставить отчет всех осмотров животного-пациентов.
    - Предоставить отчет о деталях лечения, предоставленного животному-пациенту
    - Предоставить отчет, в котором указаны максимальная, минимальная, и средняя стоимость услуг.
    - Предоставить общее количество пациентов в каждом центре, упорядочить по номеру клиники.
    - Предоставить отчет о количестве фармацевтических препаратов, упорядочить по номеру клини.
___
