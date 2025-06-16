FROM ontotext/graphdb:latest

# Copy repo config and startup script
COPY repo-config.json /repo-config.json
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Optionally disable the Workbench if needed
ENV JAVA_OPTS="-Dgraphdb.workbench.enabled=false"

# Start script
ENTRYPOINT ["/entrypoint.sh"]
