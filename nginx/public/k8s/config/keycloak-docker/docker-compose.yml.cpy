version: '3.9'

services:
  jenkins:
    restart: on-failure:10
    image: jenkins/jenkins:latest
    container_name: jenkinsadm
    ports:
      - 8090:8080
      - 5100:5000
    volumes:
      - /Workspace/jenkins_home:/var/jenkins_home
    networks:
      - cysdvps

  nexus:
    restart: on-failure:10
    image: sonatype/nexus3
    container_name: nexusimg
    ports:
      - 8099:8081
      - 5000:5000
    volumes:
      - nexus-data:/nexus-data
    networks:
      - cysdvps

  postgres:
    image: postgres:13.2
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${POSTGRESQL_DB}
      POSTGRES_USER: ${POSTGRESQL_USER}
      POSTGRES_PASSWORD: ${POSTGRESQL_PASS}
    networks:
      - cysdvps

  keycloak:
    depends_on:
      - postgres
    container_name: local_keycloak
    environment:
      KEYCLOAK_USER: admin
      KEYCLOAK_PASSWORD: 12345      
      DB_VENDOR: postgres
      DB_ADDR: postgres
      DB_DATABASE: ${POSTGRESQL_DB}
      DB_USER: ${POSTGRESQL_USER}
      DB_PASSWORD: ${POSTGRESQL_PASS}
    image: jboss/keycloak:${KEYCLOAK_VERSION}
    ports:
      - "28443:8443"
      - "28080:8080"
      - "28090:9990"
    restart: unless-stopped
    networks:
      - cysdvps

  vault-server:
    image: vault:latest
    ports:
      - "8200:8200"
    environment:
      VAULT_ADDR: "http://0.0.0.0:8200"
      VAULT_DEV_ROOT_TOKEN_ID: "vault-plaintext-root-token"
    cap_add:
      - IPC_LOCK
    networks:
      - cysdvps
        
volumes:
    nexus-data:
        driver: local
        driver_opts:
            type: 'none'
            o: 'bind'
            device: '/Workspace/Nexus'
        
networks:
  cysdvps:
    external: true