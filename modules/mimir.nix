{ ... }:
{
  flake.modules.nixos.mimir = {
    services.mimir = {
      enable = true;
      configuration = {
        multitenancy_enabled = false;

        server.http_listen_address = "localhost";
        server.http_listen_port = 9009;

        common.storage = {
          backend = "filesystem";
          filesystem.dir = "/var/lib/mimir/data";
        };

        blocks_storage.backend = "filesystem";
        blocks_storage.filesystem.dir = "/var/lib/mimir/blocks";

        ingester.ring = {
          instance_addr = "127.0.0.1";
          kvstore.store = "memberlist";
          replication_factor = 1;
        };

        store_gateway.sharding_ring.replication_factor = 1;
        compactor.sharding_ring.kvstore.store = "memberlist";
      };
    };
  };
}
