class PgUuidv7AT16 < Formula
  desc "Support for UUIDv7 in PostgreSQL"
  homepage "https://github.com/fboulnois/pg_uuidv7"
  url "https://github.com/fboulnois/pg_uuidv7/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "8891e4784878d0289593ea0fbe468e22a6dc1ee93b60e74fe04c71fd6d2600bc"
  license "Mozilla-2.0"

  depends_on "svoop/postgresql/postgresql@16"

  def postgresql
    Formula["svoop/postgresql/postgresql@16"]
  end

  def install
    ENV["PG_MAJOR"] = '16'
    system "make", "install", "PG_CONFIG=#{postgresql.opt_bin}/pg_config",
                              "pkglibdir=#{lib/postgresql.name}",
                              "datadir=#{share/postgresql.name}"
  end

  test do
    ENV["LC_ALL"] = "C"
    pg_ctl = postgresql.opt_bin/"pg_ctl"
    psql = postgresql.opt_bin/"psql"
    port = free_port

    system pg_ctl, "initdb", "-D", testpath/"test"
    (testpath/"test/postgresql.conf").write <<~EOS, mode: "a+"

      shared_preload_libraries = 'pg_uuidv7'
      port = #{port}
    EOS
    system pg_ctl, "start", "-D", testpath/"test", "-l", testpath/"log"
    begin
      system psql, "-p", port.to_s, "-c", "CREATE EXTENSION \"pg_uuidv7\";", "postgres"
    ensure
      system pg_ctl, "stop", "-D", testpath/"test"
    end
  end
end
