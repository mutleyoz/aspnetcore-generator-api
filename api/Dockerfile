# Build Stage
FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /api

COPY api.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

# Runtime Image Stage
FROM microsoft/dotnet:2.1.5-runtime-stretch-slim-arm32v7
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "api.dll"]