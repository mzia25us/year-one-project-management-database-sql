-- Reset database
DROP TABLE IF EXISTS pool_member_skills;
DROP TABLE IF EXISTS project_required_skills;
DROP TABLE IF EXISTS pool_members;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS clients;

-- Clients table (1 client can have many projects.)
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    organisation_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    contact_method ENUM('post','email') NOT NULL
);

-- Projects table (linked to clients)
-- Enforces valid date ranges.
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL, 
    project_start_date DATE NOT NULL,
    project_end_date DATE, 
    budget DECIMAL(10,2) NOT NULL, 
    project_description TEXT,
    phase ENUM('design', 'development','testing', 'deployment', 'complete') NOT NULL,
    
    CONSTRAINT fk_projects_client
        FOREIGN KEY(client_id) REFERENCES clients(client_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE, 

    CONSTRAINT chk_project_dates
        CHECK (project_end_date IS NULL OR project_end_date >= project_start_date)
);

-- Pool member table(can be unassigned or linked to a project.)
CREATE TABLE pool_members (
    pool_member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    phone VARCHAR(100) NOT NULL,
    work_address VARCHAR(255) NOT NULL,
    home_address VARCHAR(255) NOT NULL,
    
    project_id INT NULL,
    allocation_status ENUM('available', 'pending', 'assigned') NOT NULL DEFAULT 'available',
    
    CONSTRAINT fk_pool_members_project
        FOREIGN KEY(project_id) REFERENCES projects(project_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Skills table which shows the combo of skill name + type.
CREATE TABLE skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL,
    skill_type VARCHAR(100) NOT NULL,
    CONSTRAINT uq_skill UNIQUE(skill_name, skill_type)
);

-- Junction table - pool members <-> skills (many-to-many)
-- Stores experience level per skill. 
CREATE TABLE pool_member_skills (
    pool_member_id INT NOT NULL,
    skill_id INT NOT NULL,
    experience_level ENUM('Junior', 'Mid', 'Senior', 'Expert') NOT NULL,

    PRIMARY KEY (pool_member_id, skill_id),

    CONSTRAINT fk_pms_member
        FOREIGN KEY(pool_member_id) REFERENCES pool_members(pool_member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_pms_skill
        FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Junction table: projects <-> required skills (many-to-many)
CREATE TABLE project_required_skills (
    project_id INT NOT NULL,
    skill_id INT NOT NULL,

    PRIMARY KEY(project_id, skill_id),

    CONSTRAINT fk_prs_project
        FOREIGN KEY (project_id) REFERENCES projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_prs_skill
        FOREIGN KEY(skill_id) REFERENCES skills(skill_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
