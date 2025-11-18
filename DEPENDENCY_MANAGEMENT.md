# Maven Dependency Management Guide

This guide explains how to manage dependencies for the Car Rental System Spring Boot application.

## 📋 Current Dependencies (pom.xml)

The application uses Maven for dependency management. All dependencies are defined in `CarRentalSystem/pom.xml`.

### Core Dependencies

```xml
<!-- Spring Boot Web Starter - REST APIs and web development -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

<!-- Spring Boot Data JPA - Database and ORM -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<!-- Spring Boot Thymeleaf - Template engine for HTML templates -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>

<!-- H2 Database - In-memory database for development and testing -->
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>

<!-- Spring Boot Test - Unit and integration testing -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

### Versions

- **Spring Boot Parent**: 3.3.4
- **Java Version**: 17
- **All dependency versions**: Managed by Spring Boot Parent (no need to specify)

---

## 🔍 View Current Dependencies

### PowerShell

```powershell
# Show dependency tree
cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem
mvn dependency:tree

# Show resolved dependencies
mvn dependency:resolve

# Show only direct dependencies
mvn dependency:tree -DoutputFile=dependencies.txt
cat dependencies.txt

# Check for outdated dependencies
mvn versions:display-dependency-updates
```

### Command Prompt

```cmd
cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem
mvn dependency:tree
mvn dependency:resolve
mvn versions:display-dependency-updates
```

### Using Build Script

```powershell
.\build-run.ps1 dependencies
```

---

## ➕ Adding New Dependencies

### Step 1: Find the Dependency

Search Maven Central Repository: https://mvnrepository.com/

### Step 2: Add to pom.xml

Edit `CarRentalSystem/pom.xml` and add inside `<dependencies>` section:

```xml
<dependency>
    <groupId>group.id</groupId>
    <artifactId>artifact-name</artifactId>
    <version>VERSION</version>
</dependency>
```

### Step 3: Update Maven

```powershell
# Download new dependencies
mvn clean install

# Or just update
mvn dependency:resolve
```

### Step 4: Rebuild

```powershell
mvn clean package
```

---

## 📦 Common Dependencies to Add

### Security (Spring Security)

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

### MySQL Database Driver

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>
```

### PostgreSQL Driver

```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

### Lombok (Reduce boilerplate)

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
```

### Validation (Bean Validation)

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```

### REST API Documentation (Swagger/Springdoc)

```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.0.4</version>
</dependency>
```

### Email Support

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```

### JSON Processing (Jackson)

```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
</dependency>
```

### Caching

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-cache</artifactId>
</dependency>
```

---

## 🗑️ Removing Dependencies

### Step 1: Remove from pom.xml

Delete the `<dependency>` block from `CarRentalSystem/pom.xml`

### Step 2: Clean Maven Cache

```powershell
mvn clean
rm -r .m2\repository\  # Optional: clear entire Maven cache
```

### Step 3: Update

```powershell
mvn install
```

---

## 🔄 Updating Dependencies

### Check for Updates

```powershell
cd CarRentalSystem
mvn versions:display-dependency-updates
mvn versions:display-plugin-updates
```

### Update Specific Dependency

```powershell
# Update Spring Boot to latest version
mvn versions:update-child-modules
```

### Update All Dependencies

```powershell
mvn versions:use-latest-releases
```

### Rollback Updates

```powershell
mvn versions:revert
```

---

## 🔐 Dependency Security

### Check for Vulnerable Dependencies

```powershell
# Using OWASP Dependency Check
mvn org.owasp:dependency-check-maven:check
```

### Review Licenses

```powershell
mvn license:download-licenses
```

---

## 📊 Dependency Tree Example

When you run `mvn dependency:tree`, you'll see output like:

```
com.ashutosh:carrental:jar:0.0.1-SNAPSHOT
+- org.springframework.boot:spring-boot-starter-web:jar:3.3.4:compile
|  +- org.springframework.boot:spring-boot-starter:jar:3.3.4:compile
|  |  +- org.springframework.boot:spring-boot:jar:3.3.4:compile
|  |  +- org.springframework.boot:spring-boot-autoconfigure:jar:3.3.4:compile
|  |  +- org.springframework.boot:spring-boot-starter-logging:jar:3.3.4:compile
|  |  |  +- ch.qos.logback:logback-classic:jar:1.4.14:compile
|  |  |  +- org.apache.logging.log4j:log4j-to-slf4j:jar:2.21.1:compile
|  |  |  +- org.slf4j:jul-to-slf4j:jar:2.0.11:compile
|  |  +- jakarta.annotation:jakarta.annotation-api:jar:2.1.1:compile
|  |  +- org.yaml:snakeyaml:jar:2.0.33:compile
|  +- org.springframework.boot:spring-boot-starter-tomcat:jar:3.3.4:compile
|  +- org.springframework:spring-web:jar:6.1.13:compile
|  +- org.springframework:spring-webmvc:jar:6.1.13:compile
+- org.springframework.boot:spring-boot-starter-data-jpa:jar:3.3.4:compile
+- com.h2database:h2:jar:2.2.224:runtime
+- org.springframework.boot:spring-boot-starter-thymeleaf:jar:3.3.4:compile
+- org.springframework.boot:spring-boot-starter-test:jar:3.3.4:test
```

This shows:
- **Top-level**: Direct dependencies you added
- **Indented**: Transitive dependencies (added by direct dependencies)
- **Scope**: `compile`, `runtime`, `test`

---

## 🎯 Best Practices

1. **Always use Spring Boot parent version** - Ensures compatible dependency versions
2. **Don't specify versions for spring-boot dependencies** - Parent POM manages them
3. **Review dependency tree regularly** - Look for unused or conflicting dependencies
4. **Update dependencies regularly** - But test after updates
5. **Use `<scope>` tags appropriately**:
   - `compile`: Used in all build phases
   - `runtime`: Only needed at runtime
   - `test`: Only for testing
   - `provided`: Not needed for execution

6. **Keep pom.xml clean** - Remove unused dependencies

---

## 📝 Dependency Exclusion

If a dependency brings in unwanted transitive dependencies, exclude them:

```xml
<dependency>
    <groupId>some.group</groupId>
    <artifactId>some-artifact</artifactId>
    <exclusions>
        <exclusion>
            <groupId>unwanted.group</groupId>
            <artifactId>unwanted-artifact</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

---

## 🔗 Useful Resources

- **Maven Central Repository**: https://mvnrepository.com/
- **Spring Boot Dependencies**: https://mvnrepository.com/artifact/org.springframework.boot
- **Maven Documentation**: https://maven.apache.org/guides/
- **Spring Boot Starters**: https://spring.io/projects/spring-boot

---

## 📞 Troubleshooting Dependency Issues

### Issue: "Cannot find symbol" after adding dependency

**Solution:**
```powershell
mvn clean install
# Re-import project in IDE if using one
```

### Issue: Conflicting versions

**Solution:**
```powershell
mvn dependency:tree -DoutputFile=deps.txt
cat deps.txt  # Find conflicts
# Add exclusions or update versions
```

### Issue: Downloads fail

**Solution:**
```powershell
# Clear cache and retry
rm -r .m2\repository
mvn clean install
# Or check internet connection
```

---

**Last Updated**: November 11, 2025
