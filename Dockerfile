FROM ontotext/graphdb:11.0.1

# Install dos2unix to fix CRLF line endings
RUN apt-get update && apt-get install -y dos2unix

# Copy repo config and startup script
COPY repo-config.json /repo-config.json
COPY entrypoint.sh /entrypoint.sh

# Fix line endings and make executable
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Diagnostic check: verify file exists and is readable
RUN ls -l /entrypoint.sh && head -n 3 /entrypoint.sh

# Optionally disable the Workbench
ENV JAVA_OPTS="-Dgraphdb.workbench.enabled=false"

# Start script
ENTRYPOINT ["/entrypoint.sh"]
