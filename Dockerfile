#build
FROM microsoft/dotnet:2.1-sdk AS build-env

WORKDIR /generator

#restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

#display contents of working directory
#RUN ls -alR 

#copy

COPY . .

#test

ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

#publish

RUN dotnet publish api/api.csproj -o /publish /property:PublishWithAspNetCoreTargetManifest=false

#runtime

FROM microsoft/dotnet:2.1.5-runtime-stretch-slim-arm32v7

COPY --from=build-env /publish /publish

WORKDIR /publish

ENTRYPOINT [ "dotnet", "api.dll" ]