# Liquibase demo

Demo project to test different changelog formats

## Pre-requisites

+ Java 21
+ Docker, Docker Compose

## Usage

### Initial setup

1. Clone repository:

```bash
git clone https://github.com/a-sitko/liquibase-demo.git
```

2. Change current directory:

```bash
cd liquibase-demo
```

3. Start PostgreSQL container with demo database **liquibase_demo**:

```bash
docker compose up -d
```

4. Setup environment variables:

**Linux:**

```bash
export DB_URL=jdbc:postgresql://localhost:5432/liquibase_demo
export DB_USERNAME=postgres
export DB_PASSWORD=root
```

**Windows:**

```bash
set DB_URL=jdbc:postgresql://localhost:5432/liquibase_demo
set DB_USERNAME=postgres
set DB_PASSWORD=root
```

### Additional commands

To get access to the database (execute in another terminal):

```bash
docker exec -it liquibase-demo-db psql -U postgres
```

And then:

```psql
\c liquibase_demo
```

Check if there are some tables:

```psql
\d
```

To get data about changelogs:

```psql
select * from databasechangelog;
```

To stop database container:

```bash
docker compose down -v
```

To check different liquibase behavior set up environment variable `SPRING_LIQUIBASE_CONTEXTS` and start application or run application with command-line argument `-Dspring-boot.run.arguments="--spring.liquibase.contexts=context-name"`.

These environment variable and command-line argument override property `spring.liquibase.contexts`.

>[!note]
>Command-line argument will override value set up by environment variable.

### Cases to check:

#### Normal behavior with no changelogs

All changelogs with specified contexts are disabled (look at `application.yml`), so only tags **v0.0** and **v1.0** will be added to the DATABASECHANGELOG table.

**Linux:**

```bash
./mvnw spring-boot:run
```

**Windows:**

```bash
mvnw.cmd spring-boot:run
```

Interrupt with `Ctrl + C`.

Perform rollback:

**Linux:**

```bash
./mvnw liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

**Windows:**

```bash
mvnw.cmd liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

#### Normal behavior with xml-changelog

Changelog with context **xml** will be enabled in this case and **db/changelog/v1.0/01-add-users.xml** will be applied.

**Linux:**

```bash
export SPRING_LIQUIBASE_CONTEXTS=xml
./mvnw spring-boot:run
```

**Windows:**

```bash
set SPRING_LIQUIBASE_CONTEXTS=xml
mvnw.cmd spring-boot:run
```

or

**Linux:**

```bash
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=xml"
```

**Windows:**

```bash
mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=xml"
```

Interrupt with `Ctrl + C`.

Perform rollback:

**Linux:**

```bash
./mvnw liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

**Windows:**

```bash
mvnw.cmd liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

#### Normal behavior with yml-changelog

Changelog with context **yml** will be enabled in this case and **db/changelog/v1.0/10-add-users.yml** will be applied.

**Linux:**

```bash
export SPRING_LIQUIBASE_CONTEXTS=yml
./mvnw spring-boot:run
```

**Windows:**

```bash
set SPRING_LIQUIBASE_CONTEXTS=yml
mvnw.cmd spring-boot:run
```

or

**Linux:**

```bash
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=yml"
```

**Windows:**

```bash
mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=yml"
```

Interrupt with `Ctrl + C`.

Perform rollback:

**Linux:**

```bash
./mvnw liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

**Windows:**

```bash
mvnw.cmd liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

#### Normal behavior with PostgreSQL sql-changelog

Changelog with context **postgres** will be enabled in this case and **db/changelog/v1.0/30-add-users-postgres.sql** will be applied.

**Linux:**

```bash
export SPRING_LIQUIBASE_CONTEXTS=postgres
./mvnw spring-boot:run
```

**Windows:**

```bash
set SPRING_LIQUIBASE_CONTEXTS=postgres
mvnw.cmd spring-boot:run
```

or

**Linux:**

```bash
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=postgres"
```

**Windows:**

```bash
mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=postgres"
```

Interrupt with `Ctrl + C`.

Perform rollback:

**Linux:**

```bash
./mvnw liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

**Windows:**

```bash
mvnw.cmd liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

#### Fail with MySQL sql-changelog

Changelog with context **mysql** will be enabled in this case and because of MySQL specific sql-syntax not supported by PostgreSQL it will fail. As a result only **v0.0** tag will appear in the DATABASECHANGELOG table.

**Linux:**

```bash
export SPRING_LIQUIBASE_CONTEXTS=mysql
./mvnw spring-boot:run
```

**Windows:**

```bash
set SPRING_LIQUIBASE_CONTEXTS=mysql
mvnw.cmd spring-boot:run
```

or

**Linux:**

```bash
./mvnw spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=mysql"
```

**Windows:**

```bash
mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--spring.liquibase.contexts=mysql"
```

Interrupt with `Ctrl + C`.

Perform rollback:

**Linux:**

```bash
./mvnw liquibase:rollback -Dliquibase.rollbackTag=v0.0
```

**Windows:**

```bash
mvnw.cmd liquibase:rollback -Dliquibase.rollbackTag=v0.0
```
