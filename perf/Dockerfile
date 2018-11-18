FROM microsoft/dotnet:2.1-sdk as build-env

WORKDIR /app
RUN dotnet new mvc
RUN dotnet restore
RUN dotnet publish -o /published 

FROM microsoft/dotnet:2.1-aspnetcore-runtime
COPY --from=build-env /published /published

WORKDIR /published
ENTRYPOINT ["dotnet", "app.dll"]

