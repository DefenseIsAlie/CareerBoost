USE JobsData;

CREATE TABLE Skill (
    s_id VARCHAR(10),
    skill_name VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(s_id)
);

CREATE TABLE Job (
    j_id VARCHAR(10),
    job_description VARCHAR(30) NOT NULL,
    salary INT NOT NULL,
    active VARCHAR(2) NOT NULL,

    CHECK (active in ("T","F")),
    PRIMARY KEY(j_id)    
);

CREATE TABLE has_skill (
    u_id VARCHAR(10) NOT NULL,
    s_id VARCHAR(10) NOT NULL,

    PRIMARY KEY(u_id, s_id),
    FOREIGN KEY (u_id) REFERENCES PortalUser(u_id),
    FOREIGN KEY (s_id) REFERENCES Skill(s_id)
);

CREATE TABLE posts_job (
    c_id VARCHAR(10) NOT NULL,
    j_id VARCHAR(10) NOT NULL,

    PRIMARY KEY(c_id, j_id),
    FOREIGN KEY (c_id) REFERENCES Company(c_id),
    FOREIGN KEY (j_id) REFERENCES Job(j_id)
);

CREATE TABLE require_skill (
    s_id VARCHAR(10) NOT NULL,
    j_id VARCHAR(10) NOT NULL,

    PRIMARY KEY(s_id, j_id),
    FOREIGN KEY (s_id) REFERENCES Skill(s_id),
    FOREIGN KEY (j_id) REFERENCES Job(j_id)
);

CREATE TABLE hired (
    c_id VARCHAR(10) NOT NULL,
    j_id VARCHAR(10) NOT NULL,
    u_id VARCHAR(10) NOT NULL,

    PRIMARY KEY(c_id, j_id, u_id),
    FOREIGN KEY (c_id) REFERENCES Company(c_id),
    FOREIGN KEY (j_id) REFERENCES Job(j_id),
    FOREIGN KEY (u_id) REFERENCES PortalUser(u_id)
);


CREATE TABLE applies (
    j_id VARCHAR(10) NOT NULL,
    u_id VARCHAR(10) NOT NULL,

    PRIMARY KEY(j_id, u_id),
    FOREIGN KEY (j_id) REFERENCES Job(j_id),
    FOREIGN KEY (u_id) REFERENCES PortalUser(u_id)
)